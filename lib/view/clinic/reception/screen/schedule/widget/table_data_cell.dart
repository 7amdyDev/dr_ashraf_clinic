import 'package:flutter/material.dart';

class TableDataCell extends StatelessWidget {
  const TableDataCell({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FittedBox(
      fit: BoxFit.scaleDown,
      child: RichText(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            fontFamily: 'NotoNaskh',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  }
}
