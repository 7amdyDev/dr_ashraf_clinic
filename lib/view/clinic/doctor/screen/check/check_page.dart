import 'package:dr_ashraf_clinic/controller/consultation_controller.dart';
import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/check_tabbed_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/patient_info_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckPage extends StatelessWidget {
  CheckPage({super.key});
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
        // const PageLabelWidget(
        //   text: 'new_check_label',
        // ),
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
                        return const SizedBox();
                      }
                    }),
                const SizedBox(
                  height: HSizes.spaceBtwItems,
                ),
                SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.8,
                    child: const CheckTabbedPage()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
