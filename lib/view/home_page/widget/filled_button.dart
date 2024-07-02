import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HFilledButton extends StatelessWidget {
  const HFilledButton({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      iconAlignment: IconAlignment.end,
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(12), elevation: 5),
      child: Text(text.tr,
          style: HelperFunctions.isLocalEnglish()
              ? GoogleFonts.elMessiri(fontSize: 28)
              : GoogleFonts.notoNaskhArabic(fontSize: 28)),
    );
  }
}
