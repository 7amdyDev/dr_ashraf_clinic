import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/model/appointment_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/data_text_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientReceiptCashCard extends StatelessWidget {
  PatientReceiptCashCard({
    super.key,
    required this.appointData,
  });
  final AppointmentModel appointData;

  final financeController = Get.find<FinanceController>();

  @override
  Widget build(BuildContext context) {
    TextEditingController valueController = TextEditingController();
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
                //  width: 120,
                label: 'date_label'.tr,
                enable: false,
                value: HFormatter.formatStringDate(appointData.date),
              ),
              DataTextWidget(
                //width: 120,
                label: 'service_type_label'.tr,
                enable: false,
                value: HValidator.serviceIdValidation(appointData.serviceId).tr,
              ),
              Obx(
                () => DataTextWidget(
                  width: 120,
                  label: 'patient_unpaid_label'.tr,
                  enable: false,
                  textEditingController: TextEditingController(
                      text: financeController.appointUnPaid.string),
                ),
              ),
              Obx(
                () => Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: valueKey,
                  child: DataTextWidget(
                    width: 120,
                    label: 'value_label'.tr,
                    enable: financeController.appointUnPaid.value != 0
                        ? true
                        : false,
                    textEditingController: valueController,
                    validator: HValidator.validateNumber,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: HSizes.spaceBtwSections,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(
                () => financeController.appointUnPaid.value != 0
                    ? HFilledButton(
                        text: 'save_button',
                        fontSize: 22,
                        onPressed: () {
                          if (valueKey.currentState!.validate()) {
                            var valueText =
                                HFormatter.convertArabicToEnglishNumbers(
                                    valueController.value.text);
                            int amount = int.tryParse(valueText)!;
                            if (amount <=
                                financeController.appointUnPaid.value) {
                              financeController.addPatientCashReceipt(
                                  appointData, amount);
                              valueController.clear();
                              financeController
                                  .getCashRecieptOnAppointment(appointData.id!);
                            }
                          }
                        })
                    : const SizedBox(
                        width: 0,
                      ),
              ),
              Obx(() => financeController.accountRecordId.value != 0
                  ? HFilledButton(
                      fontSize: 22,
                      text: 'delete_button',
                      onPressed: () {
                        financeController.removePatientCashReceipt(
                            financeController.accountRecordId.value,
                            appointData.id!);
                        financeController
                            .getCashRecieptOnAppointment(appointData.id!);
                      })
                  : const SizedBox(
                      width: 0,
                    )),
            ],
          )
        ],
      ),
    ));
  }
}
