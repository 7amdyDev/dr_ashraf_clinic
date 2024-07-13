import 'package:dr_ashraf_clinic/model/clinic_controller.dart';
import 'package:dr_ashraf_clinic/model/patient_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/patient/widget/gender_dropdown_menu.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/data_text_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NewPatientCardWidget extends StatelessWidget {
  const NewPatientCardWidget({
    super.key,
    this.show = false,
  });

  final bool show;
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ClinicController());
    TextEditingController name = TextEditingController();
    TextEditingController mobile = TextEditingController();
    TextEditingController age = TextEditingController();
    TextEditingController address = TextEditingController();
    TextEditingController familyHistory = TextEditingController();
    TextEditingController surgicalHistory = TextEditingController();
    TextEditingController medicine = TextEditingController();
    TextEditingController allergies = TextEditingController();
    TextEditingController pastMedicalCondition = TextEditingController();
    TextEditingController notes = TextEditingController();
    int gender = 1;
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
                            textEditingController: name,
                          ),
                          DataTextWidget(
                            label: 'telephone_label'.tr,
                            textEditingController: mobile,
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
                              onSelected: (value) {
                                gender = int.parse(value);
                              },
                            ),
                          ),
                          DataTextWidget(
                            label: 'age_label'.tr,
                            enable: true,
                            textEditingController: age,
                          ),
                          DataTextWidget(
                            label: 'address_label'.tr,
                            textEditingController: address,
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
                            textEditingController: familyHistory,
                          ),
                          DataTextWidget(
                            label: 'surgical_history_label'.tr,
                            textEditingController: surgicalHistory,
                            enable: true,
                          ),
                          DataTextWidget(
                            label: 'medications_label'.tr,
                            textEditingController: medicine,
                            enable: true,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DataTextWidget(
                            label: 'allergies_label'.tr,
                            textEditingController: allergies,
                          ),
                          DataTextWidget(
                            label: 'past_medical_label'.tr,
                            textEditingController: pastMedicalCondition,
                            enable: true,
                          ),
                          DataTextWidget(
                            label: 'notes_label'.tr,
                            textEditingController: notes,
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
                              onPressed: () {
                                var patient = PatientModel(
                                  name: name.text,
                                  mobile: mobile.text,
                                  age: int.parse(age.text),
                                  address: address.text,
                                  genderType: gender,
                                  pastMedicalCondition:
                                      pastMedicalCondition.text,
                                  familyMedicalHistory: familyHistory.text,
                                  medicine: medicine.text,
                                  allergies: allergies.text,
                                  surgicalHistory: surgicalHistory.text,
                                  notes: notes.text,
                                );
                                controller.addNewPatient(patient);
                              }),
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
