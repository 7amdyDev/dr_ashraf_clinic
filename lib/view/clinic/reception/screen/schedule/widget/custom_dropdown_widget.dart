import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropDownWidget extends StatefulWidget {
  const CustomDropDownWidget({
    super.key,
    required this.statusId,
  });
  final int statusId;
  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
        value: widget.statusId,
        focusColor: Colors.transparent,
        items: [
          DropdownMenuItem(
              value: 0,
              child: TableDataCell(text: HValidator.statusIdValidation(0).tr)),
          DropdownMenuItem(
              value: 1,
              child: TableDataCell(text: HValidator.statusIdValidation(1).tr)),
          DropdownMenuItem(
              value: 2,
              child: TableDataCell(text: HValidator.statusIdValidation(2).tr)),
          DropdownMenuItem(
              value: 3,
              child: TableDataCell(text: HValidator.statusIdValidation(0).tr)),
        ],
        onChanged: (value) => setState(() => value!));
  }
}
