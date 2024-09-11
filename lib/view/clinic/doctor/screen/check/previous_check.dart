import 'package:dr_ashraf_clinic/controller/consultation_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/diagnosis_table_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/prescription_table_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/previous_check_table.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/symptoms_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreviousCheck extends StatelessWidget {
  PreviousCheck({super.key});
  final consultationController = Get.find<ConsultationController>();

  @override
  Widget build(BuildContext context) {
    consultationController.clearPrvConsultAllData();
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: HSizes.spaceBtwSections,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PreviousCheckTable(
                        searchResult: consultationController.consultationList),
                    Column(
                      children: [
                        SymptomsTableWidget(
                          symptomsList:
                              consultationController.prvCheckSymptomsList,
                          previousCheck: true,
                        ),
                        const SizedBox(
                          height: HSizes.spaceBtwItems,
                        ),
                        DiagnosisTableWidget(
                          diagnosisList:
                              consultationController.prvCheckDiagnosisList,
                          previousCheck: true,
                        ),
                      ],
                    ),
                    PrescriptionTableWidget(
                      prescriptionList:
                          consultationController.prvCheckPrescriptionList,
                      previousCheck: true,
                    ),
                  ],
                ),
                const SizedBox(
                  height: HSizes.spaceBtwSections,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
