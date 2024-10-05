import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/settings/widget/clinics_settings_table.dart';
import 'package:flutter/material.dart';

class ClinicSettingsWidget extends StatelessWidget {
  const ClinicSettingsWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: HSizes.spaceBtwSections,
          ),
          ClinicsSettingsTable()
        ],
      ),
    );
  }
}
