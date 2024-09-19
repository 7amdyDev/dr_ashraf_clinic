import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return Text(text.tr,
        style: TextStyle(
          fontFamily: 'ElMessiri',
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
        ));
  }
}
