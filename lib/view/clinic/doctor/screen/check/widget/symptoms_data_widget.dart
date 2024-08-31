import 'package:dr_ashraf_clinic/controller/consultation_controller.dart';
import 'package:dr_ashraf_clinic/model/consultation_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/doctor_text_add.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/label_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SymptomsDataInput extends StatelessWidget {
  SymptomsDataInput({
    super.key,
  });
  final consultationController = Get.find<ConsultationController>();
  @override
  Widget build(BuildContext context) {
    TextEditingController symptomEditingController = TextEditingController();
    TextEditingController bPTextController = TextEditingController();
    TextEditingController tempTextController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(8),
      width: HSizes.maxPageWidth / 4,
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          color: HColors.primaryBackground,
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              color: Colors.black,
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          LabelTextWidget(text: 'symptoms_label'.tr),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DoctorTextAddWidget(
                textEditingController: bPTextController,
                width: HSizes.maxPageWidth / 10,
                label: 'blood_pressure_label'.tr,
                onPressed: () {
                  SymptomsModel record = SymptomsModel(
                      consultationId: consultationController.consultId.value,
                      description:
                          '${'blood_pressure_label'.tr}:   ${bPTextController.text}');
                  consultationController.addSymptoms(record);
                  bPTextController.clear();
                },
              ),
              DoctorTextAddWidget(
                width: HSizes.maxPageWidth / 10,
                textEditingController: tempTextController,
                label: 'temperature_label'.tr,
                onPressed: () {
                  SymptomsModel record = SymptomsModel(
                      consultationId: consultationController.consultId.value,
                      description:
                          '${'temperature_label'.tr}:   ${tempTextController.text}');
                  consultationController.addSymptoms(record);
                  tempTextController.clear();
                },
              ),
            ],
          ),
          DoctorTextAddWidget(
            textEditingController: symptomEditingController,
            label: 'symptoms_label'.tr,
            onPressed: () {
              if (symptomEditingController.text.isNotEmpty) {
                SymptomsModel record = SymptomsModel(
                    consultationId: consultationController.consultId.value,
                    description: symptomEditingController.text);
                consultationController.addSymptoms(record);
                symptomEditingController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
