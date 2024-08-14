import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/patient_info_table.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewCheckPage extends StatelessWidget {
  const NewCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    var patientController = Get.put(PatientController());
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
                PatientInfoTable(patientModel: [
                  //patientController.getPatient()
                ])
              ],
            ),
          ),
        ),
      ],
    );
  }
}
