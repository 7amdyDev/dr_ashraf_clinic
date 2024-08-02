import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/cash_receipt_table.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/patient_reciept_cash.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CashRecieptDialogWidget extends StatelessWidget {
  const CashRecieptDialogWidget({
    super.key,
    required this.controller,
    required this.appointmentId,
    required this.recordId,
  });
  final int appointmentId;
  final int recordId;
  final FinanceController controller;

  @override
  Widget build(BuildContext context) {
    controller.getCashRecieptOnAppointment(appointmentId);
    return AlertDialog(
      elevation: 5,
      shadowColor: HColors.dark,
      backgroundColor: HColors.primaryBackground,
      title: const Center(
        child: PageLabelWidget(
          text: 'cash_receipt_label',
          fontSize: 24,
        ),
      ),
      content: SizedBox(
        width: 800,
        // height: 600,
        child: Column(
          children: [
            CashReceiptTable(searchResult: controller.appointmentCashReciept),
            PatientReceiptCashCard(
                record: controller.getAssetAccountByRecordId(recordId))
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        HFilledButton(
            fontSize: 18,
            text: 'cancel_button',
            onPressed: () {
              Get.back();
            })
      ],
    );
  }
}
