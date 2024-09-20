import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LabelTextWidget extends StatelessWidget {
  const LabelTextWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    bool isEnglish = HelperFunctions.isLocalEnglish();

    return Text(
      text.tr,
      style: isEnglish
          ? const TextStyle(
              fontFamily: 'Lato',
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )
          : const TextStyle(
              fontFamily: 'NotoNaskh',
              fontSize: 24,
              fontWeight: FontWeight.bold),
    );
  }
}
