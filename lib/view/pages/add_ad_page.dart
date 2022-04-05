import '/services/image_picker/image_picker.dart';
import '/services/firestore/publish_new_ad.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/switch_tabbar.dart';
import '../widgets/filled_button.dart';
import '../navigations/appbar.dart';
import '../widgets/text_field.dart';
import '/model/ad_type.dart';
import '/model/ad.dart';
import '/strings.dart';
import '/colors.dart';
import 'ad_page.dart';
import 'dart:io';

class AddAdPage extends StatefulWidget {
  const AddAdPage({Key? key}) : super(key: key);

  @override
  _AddAdPage createState() => _AddAdPage();
}

class _AddAdPage extends State<AddAdPage> {
  int _currentSelection = 0;
  File? image;
  Ad newAd = Ad("", "", "", "", AdType.exchange);
  bool readyToSend = false;
  bool loading = false;
  bool fieldEnabled = true;

  void updateAd(int select) {
    if (_currentSelection != select) {
      setState(() => _currentSelection = select);

    select == 0 ? newAd.type = AdType.exchange : newAd.type = AdType.search;
    }
  }

  void readytoSend() {
    if (newAd.description != "" && newAd.city != "" && newAd.description != "" && image != null) {
      setState(() => readyToSend = true);
    } else {
      setState(() => readyToSend = false);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarWidget(title: TextsSuricates.addDeal, icon: const Icon(Icons.arrow_back_ios_new), function: () {
        Navigator.pop(context);
      }),
      body: Stack(
        children: [
          Column(children: [
        Container(
            margin: const EdgeInsets.only(bottom: 4),
            child: Material(
              color: ColorsSuricates.white,
              elevation: 4.0,
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25)),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Wrap(alignment: WrapAlignment.center, children: [
                        SizedBox(
                            width: 120,
                            height: 120,
                            child: Material(
                                color: ColorsSuricates.lightGrey,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(25),
                                    onTap: () async {
                                      if (fieldEnabled == true) {
                                      var imageTemporary = await PickImage().chooseImage();
                                      setState(() => image = imageTemporary);
                                      readytoSend();
                                      }
                                    },
                                    child: image == null
                                    ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            "./images/add_img.svg"),
                                        const Text(TextsSuricates.images)
                                      ],
                                    )
                                    : ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.file(
                                      image!, fit: BoxFit.cover),
                                    )
                                    ))),
                      ])),
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: SwitchTabBar(
                    selectItem: (selectItem) => updateAd(selectItem),
                    title1: TextsSuricates.exchange,
                    title2: TextsSuricates.iSearch,
                    position: _currentSelection,
                    ))
              ]),
            )),
        Expanded(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(top: 16),
                        child: _currentSelection == 0
                            ? SuricatesTextField(
                                textInputType: TextInputType.text,
                                hint: TextsSuricates.textFieldExchange,
                                enable: fieldEnabled,
                                getText: (titleExchange) {
                                  if (_currentSelection == 0) {
                                    newAd.title = titleExchange;
                                    readytoSend();
                                  }
                                },
                              )
                              : SuricatesTextField(
                                textInputType: TextInputType.text,
                                hint: TextsSuricates.textFieldSearch,
                                enable: fieldEnabled,
                                getText: (titleSearch) {
                                  if (_currentSelection == 1) {
                                    newAd.title = titleSearch;
                                    readytoSend();
                                  }
                                },
                              )
                              ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: SuricatesTextField(
                          textInputType: TextInputType.text,
                          hint: TextsSuricates.city + '*',
                          enable: fieldEnabled,
                          getText: (city) {
                            newAd.city = city;
                            readytoSend();
                          }),
                    ),
                    SuricatesTextField(
                        textInputType: TextInputType.multiline,
                        enable: fieldEnabled,
                        hint: TextsSuricates.adPresentation,
                        maxLines: 3,
                        getText: (description) {
                          newAd.description = description;
                          readytoSend();
                        }),
                    const Text(
                      TextsSuricates.requiredTextField,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Center(
                        child:
                          FilledButton(
                              text: TextsSuricates.checkAndSend,
                              backgroundColor: ColorsSuricates.orange,
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                  readyToSend = false;
                                  fieldEnabled = false;
                                });

                                List<dynamic> result = await PublishNewAd().publishAdOnFirestore(newAd, image).timeout(const Duration (seconds:10), onTimeout: () => ["noNetwork"]);

                                if (result.contains("noNetwork")) {
                                  PublishNewAd().clearCache();
                                  setState(() {
                                    loading = false;
                                    fieldEnabled = true;
                                    readyToSend = true;
                                  });
                                } else {
                                 Navigator.pushNamed(context, "/");
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdPage(ad: result[0], url: result[2], isNetwork: true)));
                                      }
                                    },
                              enabled: readyToSend),
                        
                      ),
                  
                  ],
                ))),
      ]),
      Visibility(
        child: const LoadingWidget(),
        visible: loading,
        )
        ],
        ),
    );
  }
}
