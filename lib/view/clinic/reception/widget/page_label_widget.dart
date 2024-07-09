import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PageLabelWidget extends StatelessWidget {
  const PageLabelWidget({
    super.key,
    required this.text,
    this.fontSize = 32,
  });
  final String text;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      style: GoogleFonts.elMessiri(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
