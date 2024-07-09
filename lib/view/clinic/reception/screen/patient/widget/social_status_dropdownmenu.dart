import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialStatusDropdownMenu extends StatefulWidget {
  final Function(String) onSelected; // Callback for selection change

  const SocialStatusDropdownMenu({super.key, required this.onSelected});

  @override
  State<SocialStatusDropdownMenu> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<SocialStatusDropdownMenu> {
  String _selectedValue = 'Male'; // Default selected value

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedValue, // Currently selected value
      items: [
        DropdownMenuItem<String>(
          value: 'Male',
          child: TableDataCell(
            text: 'male_label'.tr,
          ),
        ),
        DropdownMenuItem<String>(
          value: 'Female',
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
