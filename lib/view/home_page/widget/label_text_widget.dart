import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
          ? GoogleFonts.merriweather(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )
          : GoogleFonts.notoNaskhArabic(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
    );
  }
}
