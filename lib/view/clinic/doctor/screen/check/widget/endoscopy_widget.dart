import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/doctor_text_add.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/reservation_dropdownmenu_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EndoscopyWidget extends StatelessWidget {
  const EndoscopyWidget({super.key, required this.appointId});
  final int appointId;
  @override
  Widget build(BuildContext context) {
    final financeContoller = Get.find<FinanceController>();
    final patientController = Get.find<PatientController>();
    final valueKey = GlobalKey<FormState>();
    TextEditingController amountTextEditingController = TextEditingController();
    int serviceId = 3;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 200,
          child: ServiceTypeDropDownMenu(
              listRange: const [2, 4],
              onSelected: (value) {
                serviceId = value;
              },
              serviceId: serviceId),
        ),
        Form(
          autovalidateMode: AutovalidateMode.always,
          key: valueKey,
          child: DoctorTextAddWidget(
            label: 'value_label'.tr,
            validator: HValidator.validateNumber,
            textEditingController: amountTextEditingController,
            onPressed: () {
              var amount = int.tryParse(
                  HFormatter.convertArabicToEnglishNumbers(
                      amountTextEditingController.text));
              if (valueKey.currentState!.validate() &&
                  amountTextEditingController.text.isNotEmpty) {
                financeContoller.addAccountRecievable(
                    serviceId: serviceId,
                    appointmentId: appointId,
                    patientId: patientController.patientId.value,
                    date: HFormatter.formatDate(DateTime.now(), reversed: true),
                    fee: amount!,
                    debit: amount);

                financeContoller.addAssetCashOnHand(
                    appointmentId: appointId,
                    patientId: patientController.patientId.value,
                    date: HFormatter.formatDate(DateTime.now(), reversed: true),
                    serviceId: serviceId,
                    fee: 0,
                    debit: 0);
                amountTextEditingController.clear();
              }
              Future.delayed(const Duration(milliseconds: 200), () {
                financeContoller.onPatientAccountListUpdated(
                    appointId: appointId);
              });
            },
          ),
        )
      ],
    );
  }
}
