import 'package:dr_ashraf_clinic/controller/reports_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownPeriodWidget extends StatefulWidget {
  const DropdownPeriodWidget({
    super.key,
  });

  @override
  State<DropdownPeriodWidget> createState() => _DropdownPeriodWidgetState();
}

final reportsController = Get.find<ReportsController>();
int selectedItem = 0;

class _DropdownPeriodWidgetState extends State<DropdownPeriodWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
        value: selectedItem,
        focusColor: Colors.transparent,
        alignment: Alignment.center,
        onChanged: (int? value) {
          setState(() {
            selectedItem = value!;
            switch (value) {
              case 0:
                reportsController.getIncomeExpenseWeekday();
                break;
              case 1:
                reportsController.getIncomeExpense15Days();
                break;
              case 2:
                reportsController.getIncomeExpenseMonthly();
                break;
              case 3:
                reportsController.getIncomeExpenseYearly();
                break;
            }
          });
        },
        decoration: InputDecoration(
          // labelText: 'clinic_branch_label'.tr,
          border: const OutlineInputBorder(),
        ),
        items: [
          DropdownMenuItem<int>(
            value: 0,
            child: Center(
              child: Text('last_7_days_label'.tr),
            ),
          ),
          DropdownMenuItem<int>(
            value: 1,
            child: Center(
              child: Text('last_15_days_label'.tr),
            ),
          ),
          DropdownMenuItem<int>(
            value: 2,
            child: Center(
              child: Text('monthly_label'.tr),
            ),
          ),
          DropdownMenuItem<int>(
            value: 3,
            child: Center(
              child: Text('yearly_label'.tr),
            ),
          ),
        ]);
  }
}
