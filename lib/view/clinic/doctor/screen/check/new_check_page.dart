import 'package:dr_ashraf_clinic/controller/consultation_controller.dart';
import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/diagnosis_data_input.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/diagnosis_table_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/doctor_finance_dialog.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/prescription_data_input.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/prescription_table_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/print_rouchete.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/symptoms_data_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/symptoms_table_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewCheckPage extends StatelessWidget {
  NewCheckPage({super.key});
  final consultationController = Get.find<ConsultationController>();
  final financeController = Get.find<FinanceController>();
  @override
  Widget build(BuildContext context) {
    //  var screenWidth = HelperFunctions.clinicPagesWidth();
    var width = HelperFunctions.clinicPagesWidth() / 4.5;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: SingleChildScrollView(
            primary: true,
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
                      width: width,
                    ),
                    DiagnosisDataInput(
                      width: width,
                    ),
                    PrescriptionDataInput(
                      width: width,
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
                        width: width,
                        symptomsList: consultationController.symptomsList),
                    DiagnosisTableWidget(
                        width: width,
                        diagnosisList: consultationController.diagnosisList),
                    PrescriptionTableWidget(
                      width: width,
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
                        printRouchete(
                          consultationController.prescriptionList,
                          consultationController.diagnosisList,
                        );
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
}
