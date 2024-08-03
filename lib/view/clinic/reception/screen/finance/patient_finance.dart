import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/patient_account_table.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/patient_finance_card_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/patient_reciept_cash.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/patient_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:get/get.dart';

class PatientFinance extends StatelessWidget {
  const PatientFinance({super.key});
  @override
  Widget build(BuildContext context) {
    var financeController = Get.put(FinanceController());

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: HSizes.spaceBtwSections,
        ),
        const PageLabelWidget(
          text: 'patient_finance_label',
        ),
        const SizedBox(
          height: HSizes.spaceBtwSections,
        ),
        const PatientSearchBar(),
        const PatientFinanceCardWidget(),
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
                    height: HSizes.spaceBtwItems,
                  ),
                  const PageLabelWidget(
                    text: 'patient_accounts_label',
                    fontSize: 28,
                  ),
                  const PatientAccountTable(),
                  // Obx(() => financeController.accountRecordId.value != 0
                  //     ? PatientReceiptCashCard(
                  //         record: financeController.getAssetAccountByRecordId(
                  //             financeController.accountRecordId.value))
                  //     : const SizedBox()),
                  const SizedBox(
                    height: HSizes.spaceBtwSections,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
