import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      child: Text(
        text,
        style: GoogleFonts.cairo(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
  }
}
