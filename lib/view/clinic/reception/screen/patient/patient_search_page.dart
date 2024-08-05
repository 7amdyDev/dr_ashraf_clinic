import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/patient/widget/patient_tabbed_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/search_list_form_field.dart';
import 'package:flutter/material.dart';

class PatientSearchPage extends StatelessWidget {
  const PatientSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: HSizes.spaceBtwItems,
        ),
        const PageLabelWidget(
          text: 'search_patient_label',
        ),
        Row(
          children: [
            SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SearchListFormField(
                  items: const [
                    'search_lst_patient_name_label',
                    'search_lst_telephone_no_label',
                    'search_lst_file_no_label',
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a search term';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        const Expanded(
          child: PatientTabbedPage(),
        ),
      ],
    );
  }
}
