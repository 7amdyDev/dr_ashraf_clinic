import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HFilledButton extends StatelessWidget {
  const HFilledButton({
    super.key,
    required this.text,
    this.onPressed,
    this.fontSize = 28,
  });
  final String text;
  final VoidCallback? onPressed;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      iconAlignment: IconAlignment.end,
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          disabledBackgroundColor: HColors.primaryBackground,
          disabledForegroundColor: HColors.primary,
          padding: const EdgeInsets.all(12),
          elevation: 5),
      child: Text(text.tr,
          style: HelperFunctions.isLocalEnglish()
              ? GoogleFonts.elMessiri(fontSize: fontSize)
              : GoogleFonts.notoNaskhArabic(fontSize: fontSize)),
    );
  }
}
