import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/patient_account_table.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/patient_finance_card_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/patient_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:get/get.dart';

class PatientFinance extends StatelessWidget {
  PatientFinance({super.key, this.show = true});
  final bool show;
  final financeController = Get.find<FinanceController>();
  @override
  Widget build(BuildContext context) {
    financeController.onPatientAccountListUpdated();
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        show
            ? const SizedBox(
                height: HSizes.spaceBtwSections,
              )
            : const SizedBox(),
        show
            ? const PageLabelWidget(
                text: 'patient_finance_label',
              )
            : const SizedBox(),
        const SizedBox(
          height: HSizes.spaceBtwSections,
        ),
        show ? const PatientSearchBar() : const SizedBox(),
        PatientFinanceCardWidget(),
        Expanded(
          child: SingleChildScrollView(
            primary: true,
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
                  PatientAccountTable(
                    patientAccountList:
                        financeController.totalAppointmentAccountslst,
                  ),
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
