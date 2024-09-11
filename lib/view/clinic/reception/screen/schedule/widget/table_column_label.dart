import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TableColumnLabel extends StatelessWidget {
  const TableColumnLabel({
    super.key,
    required this.text,
    this.enFontSize = 16,
    this.arFontSize = 20,
  });
  final String text;
  final double enFontSize;
  final double arFontSize;

  @override
  Widget build(BuildContext context) {
    bool isEnglish = Get.locale == const Locale('en', 'US');
    return Expanded(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          textAlign: TextAlign.center,
          text.tr,
          style: GoogleFonts.notoNaskhArabic(
            fontWeight: FontWeight.bold,
            fontSize: isEnglish ? enFontSize : arFontSize,
          ),
        ),
      ),
    );
  }
}
