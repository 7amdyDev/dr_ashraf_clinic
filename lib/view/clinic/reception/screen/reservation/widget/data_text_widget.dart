import 'package:flutter/material.dart';

class DataTextWidget extends StatelessWidget {
  const DataTextWidget({
    super.key,
    required this.label,
    this.child,
    this.value,
    this.enable = true,
    this.obscureText = false,
    this.labelFontSize = 18,
    this.textFontSize = 18,
    this.textEditingController,
    this.width = 200,
    this.validator,
    this.formKey,
    this.maxLines = 1,
    this.autoFill,
  });
  final String label;
  final String? value;
  final Widget? child;
  final bool enable;
  final bool obscureText;
  final double labelFontSize;
  final double textFontSize;
  final int maxLines;
  final double? width;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final GlobalKey? formKey;
  final List<String>? autoFill;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //  height: 105,
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
                style: TextStyle(
                  fontFamily: 'NotoNaskh',
                  fontSize: labelFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          child == null
              ? TextFormField(
                  autofillHints: autoFill,
                  style: TextStyle(
                    fontSize: textFontSize,
                  ),
                  enabled: enable,
                  initialValue: value,
                  maxLines: maxLines,
                  controller: textEditingController,
                  validator: validator,
                  obscureText: obscureText,
                )
              : child!,
        ],
      ),
    );
  }
}
