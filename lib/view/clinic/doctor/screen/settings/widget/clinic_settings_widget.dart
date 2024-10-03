import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/settings/widget/clinics_settings_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClinicSettingsWidget extends StatelessWidget {
  ClinicSettingsWidget({super.key});
  final clinicController = Get.find<ClinicController>();
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: HSizes.spaceBtwSections,
          ),
          ClinicsSettingsTable()
        ],
      ),
    );
  }
}
