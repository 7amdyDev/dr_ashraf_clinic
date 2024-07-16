import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataTextWidget extends StatelessWidget {
  const DataTextWidget({
    super.key,
    required this.label,
    this.child,
    this.value,
    this.enable = true,
    this.labelFontSize = 18,
    this.textFontSize = 18,
    this.textEditingController,
    this.width = 200,
    this.validator,
    this.formKey,
    this.maxLines = 1,
  });
  final String label;
  final String? value;
  final Widget? child;
  final bool enable;
  final double labelFontSize;
  final double textFontSize;
  final int maxLines;
  final double? width;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final GlobalKey? formKey;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: GoogleFonts.notoNaskhArabic(
                  fontSize: labelFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          child == null
              ? TextFormField(
                  style: TextStyle(
                    fontSize: textFontSize,
                  ),
                  enabled: enable,
                  initialValue: value,
                  maxLines: maxLines,
                  controller: textEditingController,
                  validator: validator,
                )
              : child!,
        ],
      ),
    );
  }
}
