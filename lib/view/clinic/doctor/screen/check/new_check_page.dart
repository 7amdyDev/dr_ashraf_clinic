import 'package:dr_ashraf_clinic/controller/consultation_controller.dart';
import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/diagnosis_data_input.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/diagnosis_table_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/prescription_data_input.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/prescription_table_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/symptoms_data_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/symptoms_table_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class NewCheckPage extends StatelessWidget {
  NewCheckPage({super.key});
  final consultationController = Get.find<ConsultationController>();
  final financeController = Get.find<FinanceController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: HSizes.spaceBtwSections,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SymptomsDataInput(),
                    DiagnosisDataInput(),
                    PrescriptionDataInput(),
                  ],
                ),
                const SizedBox(
                  height: HSizes.spaceBtwSections,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SymptomsTableWidget(
                        symptomsList: consultationController.symptomsList),
                    DiagnosisTableWidget(
                        diagnosisList: consultationController.diagnosisList),
                    PrescriptionTableWidget(
                      prescriptionList: consultationController.prescriptionList,
                    ),
                  ],
                ),
                const SizedBox(
                  height: HSizes.spaceBtwItems,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HFilledButton(
                      text: 'Print Rx',
                      onPressed: () {
                        printDoc();
                      },
                    ),
                    HFilledButton(
                      text: 'Finance',
                      onPressed: () {
                        // Get.dialog(FutureBuilder(
                        //     future: appointmentController.getAppointmentById(
                        //         consultationController.appointId.value),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.data != null) {
                        //         return DoctorFinanceDialogWidget(
                        //           controller: financeController,
                        //         );
                        //       } else {
                        //         return const CircularProgressIndicator();
                        //       }
                        //     }));

                        // financeController.getAppointmentBalance(
                        //     consultationController.appointId.value);
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: HSizes.spaceBtwItems,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> printDoc() async {
    const pageFormat = PdfPageFormat.a5;

    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: pageFormat,
        build: (pw.Context context) {
          return pw.Padding(
              padding: const pw.EdgeInsets.all(HSizes.defaultSpace),
              child: pw.Column(
                  children: consultationController.prescriptionList.map((f) {
                return pw.Text(f.medicine);
              }).toList()));
        }));

    await Printing.layoutPdf(
        format: pageFormat, onLayout: (pageFormat) async => doc.save());
  }
}
