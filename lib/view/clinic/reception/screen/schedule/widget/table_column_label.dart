import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: text.tr,
            style: TextStyle(
              fontFamily: 'NotoNaskh',
              fontWeight: FontWeight.bold,
              fontSize: isEnglish ? enFontSize : arFontSize,
            ),
          ),
        ),
      ),
    );
  }
}
