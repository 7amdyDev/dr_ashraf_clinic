import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/controller/reports_controller.dart';
import 'package:dr_ashraf_clinic/model/clinic_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownBranchWidget extends StatefulWidget {
  const DropdownBranchWidget({
    super.key,
  });

  @override
  State<DropdownBranchWidget> createState() => _DropdownBranchWidgetState();
}

final clinicController = Get.find<ClinicController>();
final reportsController = Get.find<ReportsController>();
int selectedItem = reportsController.clinicId.value;

class _DropdownBranchWidgetState extends State<DropdownBranchWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: selectedItem,
      focusColor: Colors.transparent,
      alignment: Alignment.center,
      onChanged: (int? value) {
        setState(() {
          selectedItem = value!;
          reportsController.clinicId.value = value;
          reportsController.getIncomeExpenseWeekday();
        });
      },
      decoration: InputDecoration(
        //   labelText: 'clinic_branch_label'.tr,
        border: const OutlineInputBorder(),
      ),
      items: clinicController.clinicBranches
          .map<DropdownMenuItem<int>>((ClinicId value) {
        return DropdownMenuItem<int>(
          value: value.id,
          child: Center(
              child: Text(clinicController.clinicBranches
                  .firstWhere((clinic) => clinic.id == value.id)
                  .branch
                  .tr)),
        );
      }).toList(),
    );
  }
}
