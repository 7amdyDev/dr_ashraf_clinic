import 'package:dr_ashraf_clinic/controller/consultation_controller.dart';
import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/diagnosis_data_input.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/diagnosis_table_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/doctor_finance_dialog.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/prescription_data_input.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/prescription_table_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/symptoms_data_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/symptoms_table_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    var screenWidth = HelperFunctions.clinicPagesWidth();

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
                    SymptomsDataInput(
                      width: screenWidth / 3.5,
                    ),
                    DiagnosisDataInput(
                      width: screenWidth / 3.5,
                    ),
                    PrescriptionDataInput(
                      width: screenWidth / 3.5,
                    ),
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
                        width: screenWidth / 3.5,
                        symptomsList: consultationController.symptomsList),
                    DiagnosisTableWidget(
                        width: screenWidth / 3.5,
                        diagnosisList: consultationController.diagnosisList),
                    PrescriptionTableWidget(
                      width: screenWidth / 3.5,
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
                        text: 'finance_label',
                        onPressed: () {
                          Get.dialog(DoctorFinanceDialogWidget(
                            controller: financeController,
                            appointId: consultationController.appointId.value,
                          ));
                        }),

                    // financeController.getAppointmentBalance(
                    //     consultationController.appointId.value);
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
    // Load an image from assets
    final ByteData bytes = await rootBundle.load('assets/images/logo_name.png');
    final Uint8List imageData = bytes.buffer.asUint8List();

    final image = pw.MemoryImage(imageData);
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: pageFormat,
        build: (pw.Context context) {
          return pw.Padding(
              padding: const pw.EdgeInsets.all(HSizes.defaultSpace),
              child: pw.Column(children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Image(
                        image,
                        width: 70,
                        height: 70,
                      ),
                      pw.SizedBox(
                        width: 32,
                      ),
                    ]),
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: consultationController.prescriptionList.map((f) {
                      return pw.Text(f.medicine);
                    }).toList())
              ]));
        }));

    await Printing.layoutPdf(
        format: pageFormat, onLayout: (pageFormat) async => doc.save());
  }
}
