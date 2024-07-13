import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/finance_column_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyFinanceCardWidget extends StatelessWidget {
  const DailyFinanceCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ClinicController());
    return SizedBox(
      height: 140,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FinanceValueColumn(
              label: 'daily_revenue_label',
              value: '2000',
            ),
            const VerticalDivider(
              width: 5,
              indent: 20,
              endIndent: 20,
            ),
            Obx(
              () => FinanceValueColumn(
                label: 'expenses_label',
                value: controller.totalDailyExpenses.value.toString(),
              ),
            ),
            const VerticalDivider(
              width: 5,
              indent: 20,
              endIndent: 20,
            ),
            FinanceValueColumn(
              label: 'cash_label',
              value: '1800',
            ),
          ],
        ),
      ),
    );
  }
}
