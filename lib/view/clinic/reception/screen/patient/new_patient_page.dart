import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/patient/widget/new_patient_card_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPatientPage extends StatelessWidget {
  const NewPatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClinicController());
    TextEditingController dateController = TextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: HSizes.spaceBtwSections,
        ),
        const PageLabelWidget(
          text: 'new_patient_label',
        ),
        // Row(
        //   children: [
        //     SizedBox(
        //       width: 500,
        //       child: Padding(
        //         padding: const EdgeInsets.all(16.0),
        //         child: SearchListFormField(
        //           items: const [
        //             'search_lst_patient_name_label',
        //             'search_lst_telephone_no_label',
        //             'search_lst_file_no_label',
        //           ],
        //           validator: (value) {
        //             if (value == null || value.isEmpty) {
        //               return 'Please enter a search term';
        //             }
        //             return null;
        //           },
        //         ),
        //       ),
        //     ),
        //     const Spacer(),
        //   ],
        // ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                NewPatientCardWidget(
                  show: true,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
