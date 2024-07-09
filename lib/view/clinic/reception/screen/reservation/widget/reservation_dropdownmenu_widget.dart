import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';

class ServiceTypeDropDownMenu extends StatefulWidget {
  final Function(String) onSelected; // Callback for selection change

  const ServiceTypeDropDownMenu({super.key, required this.onSelected});

  @override
  State<ServiceTypeDropDownMenu> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<ServiceTypeDropDownMenu> {
  String _selectedValue = 'Check'; // Default selected value

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedValue, // Currently selected value
      items: const [
        DropdownMenuItem<String>(
          value: 'Check',
          child: TableDataCell(
            text: 'كشف',
          ),
        ),
        DropdownMenuItem<String>(
          value: 'Consult',
          child: TableDataCell(
            text: 'إستشارة',
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