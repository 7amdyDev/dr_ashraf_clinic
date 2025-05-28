import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/settings/widget/referrals_table.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/data_text_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReferallSettingsWidget extends StatelessWidget {
  ReferallSettingsWidget({super.key});
  final clinicController = Get.find<ClinicController>();
  @override
  Widget build(BuildContext context) {
    TextEditingController addText = TextEditingController();
    return SingleChildScrollView(
      primary: true,
      child: Column(
        children: [
          const SizedBox(
            height: HSizes.spaceBtwSections,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DataTextWidget(
                        label: 'referral_label'.tr,
                        textEditingController: addText,
                      ),
                      const SizedBox(
                        width: HSizes.spaceBtwItems,
                      ),
                      HFilledButton(
                        fontSize: 22,
                        text: 'add_label',
                        onPressed: () {
                          clinicController.addReferralToDB(addText.text);
                          addText.clear();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: HSizes.spaceBtwItems,
          ),
          const ReferralsTable()
        ],
      ),
    );
  }
}
