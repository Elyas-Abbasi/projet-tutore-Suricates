import 'package:flutter/cupertino.dart';
import 'filled_button.dart';
import '/strings.dart';
import '/colors.dart';
import '/main.dart';

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
