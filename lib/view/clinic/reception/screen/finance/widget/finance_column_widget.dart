import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:flutter/material.dart';

class FinanceValueColumn extends StatelessWidget {
  const FinanceValueColumn({
    super.key,
    required this.label,
    required this.value,
    this.labelFontSize = 22,
    this.valueFontSize = 28,
  });
  final String label;
  final String value;
  final double labelFontSize;
  final double valueFontSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PageLabelWidget(
          text: label,
          fontSize: labelFontSize,
        ),
        const SizedBox(
          height: HSizes.spaceBtwItems,
        ),
        PageLabelWidget(
          text: value,
          fontSize: valueFontSize,
        ),
      ],
    );
  }
}
