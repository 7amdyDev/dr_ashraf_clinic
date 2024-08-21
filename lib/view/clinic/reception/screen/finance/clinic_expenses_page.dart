import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/daily_finance_card_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/expenses_card_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/expenses_table.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:flutter/material.dart';

class ClinicExpensesPage extends StatelessWidget {
  const ClinicExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: HSizes.spaceBtwSections,
        ),
        const PageLabelWidget(
          text: 'expenses_label',
        ),
        const SizedBox(
          height: HSizes.spaceBtwSections,
        ),
        DailyFinanceCardWidget(),
        const Expanded(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: HSizes.spaceBtwSections,
                  ),
                  PageLabelWidget(
                    text: 'expenses_table_label',
                    fontSize: 28,
                  ),
                  ExpensesTable(),
                  ExpensesCardWidget(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
