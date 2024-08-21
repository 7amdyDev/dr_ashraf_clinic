import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensesDropdownMenu extends StatefulWidget {
  final Function(int) onSelected; // Callback for selection change

  const ExpensesDropdownMenu({super.key, required this.onSelected});

  @override
  State<ExpensesDropdownMenu> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<ExpensesDropdownMenu> {
  int _selectedValue = 201; // Default selected value

  @override
  Widget build(BuildContext context) {
    var clinicController = Get.put(ClinicController());
    return DropdownButtonFormField<int>(
      value: _selectedValue, // Currently selected value
      items: clinicController.expensesId.map((expense) {
        return DropdownMenuItem<int>(
          value: expense.id,
          child: TableDataCell(
            text: HValidator.expenseCodeValidation(expense.id).tr,
          ),
        );
      }).toList(),

      onChanged: (value) {
        setState(() {
          _selectedValue = value!; // Update selected value
        });
        widget.onSelected(value!); // Call callback with selected value
      },
    );
  }
}
