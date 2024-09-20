import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/model/patient_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/patient/widget/gender_dropdown_menu.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/data_text_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewPatientCardWidget extends StatefulWidget {
  const ViewPatientCardWidget({
    super.key,
    required this.patientRecord,
  });

  final PatientModel patientRecord;

  @override
  State<ViewPatientCardWidget> createState() => _ViewPatientCardWidgetState();
}

class _ViewPatientCardWidgetState extends State<ViewPatientCardWidget> {
  TextEditingController id = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PatientController());
    final nameKey = GlobalKey<FormState>();
    final telephoneKey = GlobalKey<FormState>();
    final ageKey = GlobalKey<FormState>();
    id.text = widget.patientRecord.id.toString();
    name.text = widget.patientRecord.name;
    mobile.text = widget.patientRecord.mobile;
    age.text = widget.patientRecord.age.toString();
    address.text = widget.patientRecord.address;
    familyHistory.text = widget.patientRecord.familyMedicalHistory.toString();
    surgicalHistory.text = widget.patientRecord.surgicalHistory.toString();
    medicine.text = widget.patientRecord.medicine?.toString() ?? '';
    allergies.text = widget.patientRecord.allergies?.toString() ?? '';
    pastMedicalCondition.text =
        widget.patientRecord.pastMedicalHistory.toString();
    notes.text = widget.patientRecord.notes.toString();
    gender = widget.patientRecord.gender;
    double width = HelperFunctions.clinicPagesWidth();
    return Padding(
      padding: const EdgeInsets.all(HSizes.defaultSpace),
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(HSizes.defaultSpace),
            child: Column(
              children: [
                Text(
                  'personal_info_label'.tr,
                  style: const TextStyle(
                    fontFamily: 'NotoNaskh',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: HSizes.spaceBtwItems,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DataTextWidget(
                      label: 'id_no_label'.tr,
                      enable: false,
                      textEditingController: id,
                      width: width / 9,
                    ),
                    Form(
                      key: nameKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: DataTextWidget(
                          label: 'name_label'.tr,
                          enable: true,
                          textFontSize: 16,
                          textEditingController: name,
                          validator: HValidator.validateText,
                          width: width / 4),
                    ),
                    Form(
                      key: telephoneKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: DataTextWidget(
                        label: 'telephone_label'.tr,
                        textFontSize: 16,
                        textEditingController: mobile,
                        validator: HValidator.validateNumber,
                        enable: true,
                        width: width / 4,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DataTextWidget(
                      width: width / 9,
                      label: 'gender_label'.tr,
                      child: GenderDropdownMenu(
                        onSelected: (value) {
                          gender = int.parse(value);
                        },
                      ),
                    ),
                    Form(
                      key: ageKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: DataTextWidget(
                        label: 'age_label'.tr,
                        enable: true,
                        validator: HValidator.validateNumber,
                        textEditingController: age,
                        width: width / 4,
                      ),
                    ),
                    DataTextWidget(
                      label: 'address_label'.tr,
                      textEditingController: address,
                      enable: true,
                      width: width / 4,
                    ),
                  ],
                ),
                const SizedBox(
                  height: HSizes.spaceBtwSections,
                ),
                Text(
                  'medical_info_label'.tr,
                  style: const TextStyle(
                    fontFamily: 'NotoNaskh',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: HSizes.spaceBtwItems,
                ),
                Column(
                  children: [
                    DataTextWidget(
                      label: 'family_history_label'.tr,
                      textEditingController: familyHistory,
                      width: width * 0.8,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: HSizes.spaceBtwItems,
                    ),
                    DataTextWidget(
                      label: 'surgical_history_label'.tr,
                      textEditingController: surgicalHistory,
                      enable: true,
                      width: width * 0.8,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: HSizes.spaceBtwItems,
                    ),
                    DataTextWidget(
                      label: 'medications_label'.tr,
                      textEditingController: medicine,
                      enable: true,
                      width: width * 0.8,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: HSizes.spaceBtwItems,
                    ),
                    DataTextWidget(
                      label: 'allergies_label'.tr,
                      textEditingController: allergies,
                      width: width * 0.8,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: HSizes.spaceBtwItems,
                    ),
                    DataTextWidget(
                      label: 'past_medical_label'.tr,
                      textEditingController: pastMedicalCondition,
                      enable: true,
                      width: width * 0.8,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: HSizes.spaceBtwItems,
                    ),
                    DataTextWidget(
                      label: 'notes_label'.tr,
                      textEditingController: notes,
                      enable: true,
                      width: width * 0.8,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: HSizes.spaceBtwItems,
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
                        text: 'update_button',
                        fontSize: 22,
                        onPressed: () {
                          var patient = PatientModel(
                            id: widget.patientRecord.id,
                            name: name.text,
                            mobile: HFormatter.convertArabicToEnglishNumbers(
                                mobile.text),
                            age: int.parse(
                                HFormatter.convertArabicToEnglishNumbers(
                                    age.text)),
                            address: address.text,
                            gender: gender,
                            pastMedicalHistory: pastMedicalCondition.text,
                            familyMedicalHistory: familyHistory.text,
                            medicine: medicine.text,
                            allergies: allergies.text,
                            surgicalHistory: surgicalHistory.text,
                            notes: notes.text,
                          );
                          if (nameKey.currentState!.validate() &&
                              telephoneKey.currentState!.validate() &&
                              ageKey.currentState!.validate()) {
                            controller.updatePatient(patient);
                          }
                        }),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
