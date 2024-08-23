import 'package:dr_ashraf_clinic/controller/expense_controller.dart';
import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/finance_column_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyFinanceCardWidget extends StatelessWidget {
  DailyFinanceCardWidget({
    super.key,
  });
  final financeController = Get.put(FinanceController());
  final expenseController = Get.put(ExpenseController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(
              () => FinanceValueColumn(
                label: 'daily_revenue_label',
                value: financeController.dailyIncome.string,
              ),
            ),
            const VerticalDivider(
              width: 5,
              indent: 20,
              endIndent: 20,
            ),
            Obx(
              () => FinanceValueColumn(
                label: 'expenses_label',
                value: expenseController.totalDailyExpenses.string,
              ),
            ),
            const VerticalDivider(
              width: 5,
              indent: 20,
              endIndent: 20,
            ),
            Obx(
              () => FinanceValueColumn(
                label: 'cash_label',
                value: financeController.cash.string,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
