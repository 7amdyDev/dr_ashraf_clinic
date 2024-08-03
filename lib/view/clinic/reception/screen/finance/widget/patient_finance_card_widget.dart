import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/finance_column_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientFinanceCardWidget extends StatelessWidget {
  const PatientFinanceCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var finaceController = Get.put(FinanceController());
    return SizedBox(
      height: 140,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(
              () => FinanceValueColumn(
                label: 'patient_accounts_label',
                value: finaceController.patientBalance.value.toString(),
              ),
            ),
            const VerticalDivider(
              width: 5,
              indent: 20,
              endIndent: 20,
            ),
            Obx(
              () => FinanceValueColumn(
                label: 'patient_paid_label',
                value: finaceController.patientTotalPaid.value.toString(),
              ),
            ),
            const VerticalDivider(
              width: 5,
              indent: 20,
              endIndent: 20,
            ),
            Obx(
              () => FinanceValueColumn(
                label: 'patient_unpaid_label',
                value: finaceController.patientTotalUnPaid.value.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
