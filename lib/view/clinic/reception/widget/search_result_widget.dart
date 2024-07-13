import 'package:dr_ashraf_clinic/model/clinic_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/patient_search_table.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchDialogWidget extends StatelessWidget {
  const SearchDialogWidget({
    super.key,
    required this.controller,
  });

  final ClinicController controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 5,
      shadowColor: HColors.dark,
      backgroundColor: HColors.primaryBackground,
      title: const Center(
        child: PageLabelWidget(
          text: 'search_result_label',
          fontSize: 24,
        ),
      ),
      content: SizedBox(
        width: 800,
        // height: 600,
        child:
            PatientSearchTable(searchResult: controller.patientList.toList()),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        HFilledButton(
          fontSize: 18,
          text: 'cancel_button',
          onPressed: () => Get.back(),
        )
      ],
    );
  }
}
