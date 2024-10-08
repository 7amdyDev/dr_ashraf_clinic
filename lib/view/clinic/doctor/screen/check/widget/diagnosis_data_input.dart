import 'package:dr_ashraf_clinic/controller/consultation_controller.dart';
import 'package:dr_ashraf_clinic/model/consultation_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/doctor_text_add.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/label_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiagnosisDataInput extends StatelessWidget {
  DiagnosisDataInput({
    super.key,
    required this.width,
  });
  final double width;
  final consultationController = Get.find<ConsultationController>();
  @override
  Widget build(BuildContext context) {
    TextEditingController diagnosisEditingController = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(8),
      width: width,
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          color: HColors.primaryBackground,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              color: Colors.black,
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          LabelTextWidget(text: 'diagnosis_label'.tr),
          DoctorTextAddWidget(
            textEditingController: diagnosisEditingController,
            label: 'diagnosis_label'.tr,
            onPressed: () {
              if (diagnosisEditingController.text.isNotEmpty) {
                DiagnosisModel record = DiagnosisModel(
                    consultationId: consultationController.consultId.value,
                    description: diagnosisEditingController.text);
                consultationController.addDiagnosis(record);
                diagnosisEditingController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
