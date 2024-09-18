import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorTextAddWidget extends StatelessWidget {
  const DoctorTextAddWidget({
    super.key,
    required this.label,
    this.value,
    this.enable = true,
    this.labelFontSize = 18,
    this.textFontSize = 18,
    this.textEditingController,
    this.width = 200,
    this.validator,
    this.maxLines = 1,
    this.onPressed,
  });
  final String label;
  final String? value;
  final bool enable;
  final double labelFontSize;
  final double textFontSize;
  final int maxLines;
  final double? width;
  final String? Function(String?)? validator;

  final TextEditingController? textEditingController;
  final VoidCallback? onPressed;

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
          TextFormField(
            validator: validator,
            style: TextStyle(
              fontSize: textFontSize,
            ),
            onEditingComplete: onPressed,
            decoration: InputDecoration(
              prefixIcon: IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  color: HColors.primary,
                ),
                onPressed: onPressed,
              ),
            ),
            enabled: enable,
            maxLines: maxLines,
            controller: textEditingController,
          ),
        ],
      ),
    );
  }
}
