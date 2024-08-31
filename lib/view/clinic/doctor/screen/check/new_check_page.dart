import 'package:dr_ashraf_clinic/controller/consultation_controller.dart';
import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/diagnosis_data_input.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/diagnosis_table_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/patient_info_table.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/prescription_data_input.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/prescription_table_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/symptoms_data_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/symptoms_table_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/search_list_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewCheckPage extends StatelessWidget {
  NewCheckPage({super.key});
  final patientController = Get.find<PatientController>();
  final consultationController = Get.find<ConsultationController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: HSizes.spaceBtwSections,
        ),
        const PageLabelWidget(
          text: 'new_check_label',
        ),
        const SizedBox(
          height: HSizes.spaceBtwSections,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                FutureBuilder(
                    future: patientController
                        .getPatientById(patientController.patientId.value),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return PatientInfoTable(patientModel: snapshot.data!);
                      } else {
                        return Row(
                          children: [
                            SizedBox(
                              width: 500,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SearchListFormField(
                                  items: const [
                                    'search_lst_patient_name_label',
                                    'search_lst_telephone_no_label',
                                    'search_lst_file_no_label',
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a search term';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        );
                      }
                    }),
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
                        consultationId: consultationController.consultId.value),
                    DiagnosisTableWidget(
                        consultationId: consultationController.consultId.value),
                    PrescriptionTableWidget(),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
