import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import '../pages/main_page.dart';
import '/strings.dart';
import '/globals.dart';
import '/colors.dart';

class MyOnboarding extends StatefulWidget {
  const MyOnboarding({
    Key? key,
  }) : super(key: key);

  @override
  _MyOnboarding createState() => _MyOnboarding();
}

class _MyOnboarding extends State<MyOnboarding> {

  late final listPagesViewModel = [
    PageViewModel(
      decoration: const PageDecoration(pageColor: ColorsSuricates.white),
      titleWidget: const Padding(
        padding: EdgeInsets.only(top: 80,),
        child: Text(
          "👋",
          style: TextStyle(fontSize: 180),
        ),
      ),
      bodyWidget: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          TextsSuricates.page1Titre,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: Text(
                              TextsSuricates.page1Message1,
                          textAlign: TextAlign.center,),
                        ),
                        Text(
                            TextsSuricates.page1Message2,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    PageViewModel(
      decoration: const PageDecoration(pageColor: ColorsSuricates.white),
      titleWidget: const Padding(
        padding: EdgeInsets.only(top: 80,),
        child: Text(
          "📦",
          style: TextStyle(fontSize: 180),
        ),
      ),
      bodyWidget: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          TextsSuricates.page2Titre,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: Text(
                            TextsSuricates.page2Message1,
                            textAlign: TextAlign.center,),
                        ),
                        Text(
                          TextsSuricates.page2Message2,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    PageViewModel(
      decoration: const PageDecoration(pageColor: ColorsSuricates.white),
      titleWidget: const Padding(
        padding: EdgeInsets.only(top: 80,),
        child: Text(
          "🔎",
          style: TextStyle(fontSize: 180),
        ),
      ),
      bodyWidget: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          TextsSuricates.page3Titre,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: Text(
                            TextsSuricates.page3Message1,
                            textAlign: TextAlign.center,),
                        ),
                        Text(
                          TextsSuricates.page3Message2,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: listPagesViewModel,
        showDoneButton: true,
        showSkipButton: true,
        showNextButton: true,
        done: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: ColorsSuricates.white,
        ),
        next: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: ColorsSuricates.white,
        ),
        skip: const Text(
          TextsSuricates.skip,
          style: TextStyle(color: ColorsSuricates.white),
        ),
        onDone: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(currentUser: currentUser),
              ))
        },
        globalBackgroundColor: ColorsSuricates.blue,
        dotsDecorator: const DotsDecorator(
          color: ColorsSuricates.white,
          activeColor: ColorsSuricates.white,
          activeSize: Size.square(12),
          size: Size.square(8)
        ),
      ),
    );
  }
}
