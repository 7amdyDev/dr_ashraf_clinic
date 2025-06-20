import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenderDropdownMenu extends StatefulWidget {
  final Function(String) onSelected; // Callback for selection change
  final String? selectedValue; // Optional initial value
  const GenderDropdownMenu(
      {super.key, required this.onSelected, this.selectedValue});

  @override
  State<GenderDropdownMenu> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<GenderDropdownMenu> {
  String _selectedValue = '1'; // Default selected value

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      style: const TextStyle(
        fontFamily: 'NotoNaskh',
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      value: widget.selectedValue ?? _selectedValue, // Currently selected value
      items: [
        DropdownMenuItem<String>(
          value: '1',
          child: TableDataCell(
            text: 'male_label'.tr,
          ),
        ),
        DropdownMenuItem<String>(
          value: '2',
          child: TableDataCell(
            text: 'female_label'.tr,
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
