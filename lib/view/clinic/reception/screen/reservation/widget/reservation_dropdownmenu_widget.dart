import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceTypeDropDownMenu extends StatefulWidget {
  final Function(int) onSelected; // Callback for selection change
  final int serviceId;
  final List<int> listRange;
  const ServiceTypeDropDownMenu(
      {super.key,
      required this.onSelected,
      required this.serviceId,
      required this.listRange});

  @override
  State<ServiceTypeDropDownMenu> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<ServiceTypeDropDownMenu> {
  // Default selected value

  @override
  Widget build(BuildContext context) {
    int selectedValue = widget.serviceId;
    var clinicController = Get.put(ClinicController());
    var list = clinicController.servicesId
        .getRange(widget.listRange[0], widget.listRange[1]);

    return DropdownButtonFormField<int>(
      value: selectedValue, // Currently selected value
      items: list.map((service) {
        return DropdownMenuItem<int>(
          value: service.id,
          child: TableDataCell(
            text: HValidator.serviceIdValidation(service.id).tr,
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedValue = value!; // Update selected value
        });
        widget.onSelected(value!); // Call callback with selected value
      },
    );
  }
}
