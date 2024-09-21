import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';

class TableDataCell extends StatelessWidget {
  const TableDataCell({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    bool english = HelperFunctions.isLocalEnglish();
    return Center(
        child: FittedBox(
      fit: BoxFit.scaleDown,
      child: RichText(
        text: TextSpan(
          text: text,
          style: TextStyle(
            fontFamily: 'NotoNaskh',
            fontSize: english ? 16 : 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  }
}
