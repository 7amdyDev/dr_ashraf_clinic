import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropDownWidget extends StatefulWidget {
  const CustomDropDownWidget({
    super.key,
  });

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

List<String> status = ['no show', 'waiting', 'completed', 'canceled'];

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  String i = status[0];
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: i,
        focusColor: Colors.transparent,
        items: [
          DropdownMenuItem(
              value: status[0], child: TableDataCell(text: 'no_show_label'.tr)),
          DropdownMenuItem(
              value: status[1], child: TableDataCell(text: 'waiting_label'.tr)),
          DropdownMenuItem(
              value: status[2],
              child: TableDataCell(text: 'completed_label'.tr)),
          DropdownMenuItem(
              value: status[3],
              child: TableDataCell(text: 'canceled_label'.tr)),
        ],
        onChanged: (value) => setState(() => i = value!));
  }
}
