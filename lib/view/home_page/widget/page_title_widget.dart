import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
          ? GoogleFonts.outfit(
              fontSize: 32,
              fontWeight: FontWeight.w400,
              shadows: [
                const BoxShadow(
                    color: Colors.black38, offset: Offset(0, 2), blurRadius: 2)
              ],
              color: HColors.primary)
          : GoogleFonts.elMessiri(
              fontSize: 36,
              shadows: [
                const BoxShadow(
                    color: Colors.black38, offset: Offset(0, 2), blurRadius: 2)
              ],
              fontWeight: FontWeight.w400,
              color: HColors.primary),
    );
  }
}
