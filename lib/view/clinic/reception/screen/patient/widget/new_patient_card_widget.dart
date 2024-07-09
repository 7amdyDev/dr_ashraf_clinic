import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/patient/widget/gender_dropdown_menu.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/patient_data_chip.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class NewPatientCardWidget extends StatelessWidget {
  const NewPatientCardWidget({
    super.key,
    this.show = false,
  });

  final bool show;
  @override
  Widget build(BuildContext context) {
    return show
        ? Padding(
            padding: const EdgeInsets.all(HSizes.defaultSpace),
            child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(HSizes.defaultSpace),
                  child: Column(
                    children: [
                      Text(
                        'personal_info_label'.tr,
                        style: GoogleFonts.cairo(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: HSizes.spaceBtwItems,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DataTextWidget(
                            label: 'id_no_label'.tr,
                            enable: false,
                            width: 100,
                          ),
                          DataTextWidget(
                            label: 'name_label'.tr,
                            enable: true,
                          ),
                          DataTextWidget(
                            label: 'telephone_label'.tr,
                            enable: true,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DataTextWidget(
                            width: 100,
                            label: 'gender_label'.tr,
                            child: GenderDropdownMenu(
                              onSelected: (value) {},
                            ),
                          ),
                          DataTextWidget(
                            label: 'age_label'.tr,
                            enable: true,
                          ),
                          DataTextWidget(
                            label: 'address_label'.tr,
                            enable: true,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: HSizes.spaceBtwSections,
                      ),
                      Text(
                        'medical_info_label'.tr,
                        style: GoogleFonts.cairo(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: HSizes.spaceBtwItems,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DataTextWidget(
                            label: 'family_history_label'.tr,
                          ),
                          DataTextWidget(
                            label: 'surgical_history_label'.tr,
                            enable: true,
                          ),
                          DataTextWidget(
                            label: 'medications_label'.tr,
                            enable: true,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DataTextWidget(
                            label: 'allergies_label'.tr,
                          ),
                          DataTextWidget(
                            label: 'past_medical_label'.tr,
                            enable: true,
                          ),
                          DataTextWidget(
                            label: 'notes_label'.tr,
                            enable: true,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: HSizes.spaceBtwItems,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          HFilledButton(
                              text: 'save_button',
                              fontSize: 22,
                              onPressed: () {}),
                          HFilledButton(
                              text: 'book_sheet_label',
                              fontSize: 22,
                              onPressed: null),
                        ],
                      )
                    ],
                  )),
            ),
          )
        : const SizedBox();
  }
}
