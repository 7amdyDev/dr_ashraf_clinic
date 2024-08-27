import 'package:dr_ashraf_clinic/controller/consultation_controller.dart';
import 'package:dr_ashraf_clinic/model/consultation_model.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/doctor_text_add.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/label_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiagnosisDataInput extends StatelessWidget {
  DiagnosisDataInput({
    super.key,
  });
  final consultationController = Get.find<ConsultationController>();
  @override
  Widget build(BuildContext context) {
    TextEditingController diagnosisEditingController = TextEditingController();
    return Container(
      width: HelperFunctions.screenWidth() / 4,
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              color: Colors.white10,
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          const LabelTextWidget(text: 'Diagnostics Data'),
          DoctorTextAddWidget(
            textEditingController: diagnosisEditingController,
            label: 'Diagnostic',
            onPressed: () {
              DiagnosisModel record = DiagnosisModel(
                  consultationId: consultationController.consultId.value,
                  description: diagnosisEditingController.text);
              consultationController.addDiagnosis(record);
              diagnosisEditingController.clear();
            },
          ),
        ],
      ),
    );
  }
}
