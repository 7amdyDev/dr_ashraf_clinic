import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/model/appointment_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/cash_receipt_table.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/patient_reciept_cash.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:flutter/material.dart';

class CashRecieptDialogWidget extends StatelessWidget {
  const CashRecieptDialogWidget({
    super.key,
    required this.controller,
    required this.appointData,
  });
  final AppointmentModel appointData;
  final FinanceController controller;

  @override
  Widget build(BuildContext context) {
    controller.getCashRecieptOnAppointment(appointData.id!);
    controller.getAppointmentBalance(appointData.id!);
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
          mainAxisSize: MainAxisSize.min,
          children: [
            CashReceiptTable(searchResult: controller.appointmentCashReciept),
            const SizedBox(height: HSizes.spaceBtwItems),
            PatientReceiptCashCard(
              appointData: appointData,
            )
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
