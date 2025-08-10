import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LabelTextWidget extends StatelessWidget {
  const LabelTextWidget({
    super.key,
    required this.text,
    this.fontSizeEn = 22,
    this.fontSizeAr = 24,
  });

  final String text;
  final double fontSizeEn;
  final double fontSizeAr;

  @override
  Widget build(BuildContext context) {
    bool isEnglish = HelperFunctions.isLocalEnglish();

    return FittedBox(
      child: Text(
        text.tr,
        style: isEnglish
            ? TextStyle(
                fontFamily: 'Lato',
                fontSize: fontSizeEn,
                fontWeight: FontWeight.bold,
              )
            : TextStyle(
                fontFamily: 'NotoNaskh',
                fontSize: fontSizeAr,
                fontWeight: FontWeight.bold,
              ),
      ),
    );
  }
}
