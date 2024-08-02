import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';

class ServiceTypeDropDownMenu extends StatefulWidget {
  final Function(int) onSelected; // Callback for selection change
  final int serviceId;
  const ServiceTypeDropDownMenu(
      {super.key, required this.onSelected, required this.serviceId});

  @override
  State<ServiceTypeDropDownMenu> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<ServiceTypeDropDownMenu> {
  // Default selected value

  @override
  Widget build(BuildContext context) {
    int selectedValue = widget.serviceId;
    return DropdownButtonFormField<int>(
      value: selectedValue, // Currently selected value
      items: const [
        DropdownMenuItem<int>(
          value: 0,
          child: TableDataCell(
            text: 'كشف',
          ),
        ),
        DropdownMenuItem<int>(
          value: 1,
          child: TableDataCell(
            text: 'متابعة',
          ),
        ),
      ],
      onChanged: (value) {
        setState(() {
          selectedValue = value!; // Update selected value
        });
        widget.onSelected(value!); // Call callback with selected value
      },
    );
  }
}
