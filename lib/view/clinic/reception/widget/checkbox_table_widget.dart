import 'package:dr_ashraf_clinic/controller/appointment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TableCheckBoxWidget extends StatefulWidget {
  const TableCheckBoxWidget({
    super.key,
  });
  @override
  State<TableCheckBoxWidget> createState() => _TableCheckBoxState();
}

class _TableCheckBoxState extends State<TableCheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AppointmentController());
    return Checkbox(
        value: controller.paid.value,
        onChanged: (value) {
          setState(() {
            controller.paid.value = value!;
          });
        });
  }
}
