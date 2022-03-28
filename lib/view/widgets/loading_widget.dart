import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suricates_app/colors_suricates.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      backgroundColor: ColorsSuricates.blue,
      valueColor: AlwaysStoppedAnimation<Color>(ColorsSuricates.orange),
    ));
  }
}
