import 'package:flutter/cupertino.dart';
import 'package:suricates_app/colors_suricates.dart';
import 'package:suricates_app/main.dart';
import 'package:suricates_app/strings.dart';
import 'package:suricates_app/view/widgets/filled_button.dart';

class ErrorMessageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            TextsSuricates.errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorsSuricates.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FilledButton(
            text: "Réessayer",
            enabled: true,
            onPressed: () {
              runApp(const MyApp());
            },
          )
        ],
      ),
    );
  }
}
