import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/patient_account_table.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/patient_finance_card_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/patient_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';

class PatientFinance extends StatelessWidget {
  const PatientFinance({super.key, this.show = true});

  final bool show;
  @override
  Widget build(BuildContext context) {
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
        const PatientFinanceCardWidget(),
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
                    height: HSizes.spaceBtwItems,
                  ),
                  PageLabelWidget(
                    text: 'patient_accounts_label',
                    fontSize: 28,
                  ),
                  PatientAccountTable(),
                  SizedBox(
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
