import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageTitleWidget extends StatelessWidget {
  const PageTitleWidget({
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
              fontFamily: 'Oswald',
              fontSize: 32,
              fontWeight: FontWeight.w400,
              shadows: [
                BoxShadow(
                    color: Colors.black38, offset: Offset(0, 2), blurRadius: 2)
              ],
              color: HColors.primary)
          : const TextStyle(
              fontFamily: 'ElMessiri',
              fontSize: 36,
              shadows: [
                BoxShadow(
                    color: Colors.black38, offset: Offset(0, 2), blurRadius: 2)
              ],
              fontWeight: FontWeight.w400,
              color: HColors.primary),
    );
  }
}
