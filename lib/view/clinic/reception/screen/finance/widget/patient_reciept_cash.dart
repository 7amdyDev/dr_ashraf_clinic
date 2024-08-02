import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/model/finance_models.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/data_text_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientReceiptCashCard extends StatelessWidget {
  const PatientReceiptCashCard({
    super.key,
    required this.record,
  });
  final AssetAccountsModel record;
  @override
  Widget build(BuildContext context) {
    TextEditingController valueController = TextEditingController();
    final financeController = Get.put(FinanceController());
    final valueKey = GlobalKey<FormState>();

    return Card(
      child: Padding(
          padding: const EdgeInsets.all(HSizes.defaultSpace),
          child: Column(
            children: [
              Text(
                'cash_receipt_label'.tr,
                style: GoogleFonts.cairo(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Divider(),
              const SizedBox(
                height: HSizes.spaceBtwItems,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DataTextWidget(
                    label: 'date_label'.tr,
                    enable: false,
                    value: record.dateTime,
                  ),
                  DataTextWidget(
                    label: 'service_type_label'.tr,
                    enable: false,
                    value: HValidator.serviceIdValidation(record.serviceId).tr,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: valueKey,
                    child: DataTextWidget(
                      label: 'value_label'.tr,
                      enable: true,
                      textEditingController: valueController,
                      validator: HValidator.validateNumber,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: HSizes.spaceBtwSections,
              ),
              HFilledButton(
                  text: 'save_button',
                  fontSize: 22,
                  onPressed: () {
                    if (valueKey.currentState!.validate()) {
                      var valueText = HFormatter.convertArabicToEnglishNumbers(
                          valueController.value.text);
                      record.debit += int.tryParse(valueText)!;
                      financeController.patientCashReceipt(record);
                      valueController.clear();
                    }
                  }),
            ],
          )),
    );
  }
}
