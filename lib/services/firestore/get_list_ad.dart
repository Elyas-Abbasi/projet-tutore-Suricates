import 'package:cloud_firestore/cloud_firestore.dart';
import '/view/widgets/error_message_widget.dart';
import '../firebase_stockage/get_image.dart';
import '/view/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import '/view/widgets/list_item.dart';
import '/view/widgets/info_bar.dart';
import '/view/pages/ad_page.dart';
import '/model/ad.dart';
import '/strings.dart';

// va chercher la liste des annonces sur firebase en précisant en paramètre si elles sont de type search ou exchange
class GetListAd extends StatelessWidget {
  final String? type;
  final String? justUserAds;

  const GetListAd({
    Key? key,
    this.type,
    this.justUserAds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference trocs = FirebaseFirestore.instance.collection('trocs');

    // si un userId est spécifié, alors ne s'affiche que ses annonces.
    Future<QuerySnapshot> whichFuture() {
      if (justUserAds != null) {
        return trocs.where("userID", isEqualTo: justUserAds).limit(20).get();
      } else {
        return trocs.where("type", isEqualTo: type).limit(20).get();
      }
    }

    return FutureBuilder<QuerySnapshot>(
      future: whichFuture(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const ErrorMessageWidget();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            Ad ad = Ad.fromSnapShot(snapshot.data!.docs[index]);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  index == 0 && type != null
                      ? InfoBar(
                          text: type == "exchange"
                              ? TextsSuricates.hereWhatSuricatesHaveForYou
                              : TextsSuricates.hereWhatSuricatesLookFor,
                        )
                      : Container(),
                  FutureBuilder(
                    future: GetImage.get(ad.id, "ad_images"),
                    builder: (context, snap) {
                      if (snap.hasError ||
                          snapshot.connectionState == ConnectionState.waiting ||
                          snap.data == null) {
                        return ListItemWidget(
                          ad: ad,
                          url: "images/unknown.jpg",
                          onTapItem: () {
                            WidgetsBinding.instance?.addPostFrameCallback((_) {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (
                                    context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation,
                                  ) =>
                                      AdPage(
                                    ad: ad,
                                    url: "images/unknown.jpg",
                                    isNetwork: false,
                                  ),
                                  transitionsBuilder: (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
                                    const begin = Offset(1.0, 0.0);
                                    const end = Offset.zero;
                                    const curve = Curves.ease;

                                    var tween = Tween(
                                      begin: begin,
                                      end: end,
                                    ).chain(CurveTween(curve: curve));

                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            });
                          },
                          isNetwork: false,
                        );
                      } else {
                        return ListItemWidget(
                          ad: ad,
                          url: snap.data.toString(),
                          onTapItem: () {
                            WidgetsBinding.instance?.addPostFrameCallback((_) {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (
                                    context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation,
                                  ) =>
                                      AdPage(
                                    ad: ad,
                                    url: snap.data.toString(),
                                    isNetwork: true,
                                  ),
                                  transitionsBuilder: (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
                                    const begin = Offset(1.0, 0.0);
                                    const end = Offset.zero;
                                    const curve = Curves.ease;

                                    var tween = Tween(
                                      begin: begin,
                                      end: end,
                                    ).chain(CurveTween(curve: curve));

                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            });
                          },
                          isNetwork: true,
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
