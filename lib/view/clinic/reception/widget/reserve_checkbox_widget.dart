import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReserveCheckboxWidget extends StatefulWidget {
  const ReserveCheckboxWidget({
    super.key,
    required this.appointId,
  });
  final String appointId;
  @override
  State<ReserveCheckboxWidget> createState() =>
      _ReserveCheckboxWidgetCheckBoxState();
}

class _ReserveCheckboxWidgetCheckBoxState extends State<ReserveCheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ClinicController());
    return Checkbox(
        value: false,
        onChanged: (value) {
          setState(() {
            controller.deleteOnlineReserv(widget.appointId);
          });
        });
  }
}
