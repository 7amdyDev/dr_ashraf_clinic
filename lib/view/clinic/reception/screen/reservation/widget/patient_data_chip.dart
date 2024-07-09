import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataTextWidget extends StatelessWidget {
  const DataTextWidget({
    super.key,
    required this.label,
    this.child,
    this.value,
    this.enable = true,
    this.labeFontSize = 18,
    this.textEditingController,
    this.width = 200,
  });
  final String label;
  final String? value;
  final Widget? child;
  final bool enable;
  final double labeFontSize;
  final double width;
  final TextEditingController? textEditingController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              label,
              style: GoogleFonts.notoNaskhArabic(
                fontSize: labeFontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          child == null
              ? ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 200),
                  child: TextFormField(
                    enabled: enable,
                    initialValue: value,
                    controller: textEditingController,
                  ),
                )
              : child!,
        ],
      ),
    );
  }
}
