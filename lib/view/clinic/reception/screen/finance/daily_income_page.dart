import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/daily_finance_card_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/daily_income_table.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyIncomePage extends StatelessWidget {
  DailyIncomePage({super.key});
  final financeController = Get.find<FinanceController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: HSizes.spaceBtwSections,
        ),
        const PageLabelWidget(
          text: 'finance_label',
        ),
        Expanded(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: HSizes.spaceBtwSections,
                  ),
                  DailyFinanceCardWidget(),
                  const SizedBox(
                    height: HSizes.spaceBtwSections,
                  ),
                  const PageLabelWidget(
                    text: 'daily_revenue_label',
                    fontSize: 24,
                  ),
                  DailyIncomeTable(
                      searchResult: financeController.assetDailyIncomelst)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
