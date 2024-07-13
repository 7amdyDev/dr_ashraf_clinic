import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensesDropdownMenu extends StatefulWidget {
  final Function(String) onSelected; // Callback for selection change

  const ExpensesDropdownMenu({super.key, required this.onSelected});

  @override
  State<ExpensesDropdownMenu> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<ExpensesDropdownMenu> {
  String _selectedValue = '201'; // Default selected value

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedValue, // Currently selected value
      items: [
        DropdownMenuItem<String>(
          value: '201',
          child: TableDataCell(
            text: 'medical_supplies_label'.tr,
          ),
        ),
        DropdownMenuItem<String>(
          value: '202',
          child: TableDataCell(
            text: 'rent_label'.tr,
          ),
        ),
        DropdownMenuItem<String>(
          value: '203',
          child: TableDataCell(
            text: 'utilities_label'.tr,
          ),
        ),
        DropdownMenuItem<String>(
          value: '204',
          child: TableDataCell(
            text: 'salaries_label'.tr,
          ),
        ),
        DropdownMenuItem<String>(
          value: '205',
          child: TableDataCell(
            text: 'other_label'.tr,
          ),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _selectedValue = value!; // Update selected value
        });
        widget.onSelected(value!); // Call callback with selected value
      },
    );
  }
}