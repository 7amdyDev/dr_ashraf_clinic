import 'package:dr_ashraf_clinic/view/clinic/reception/widget/search_list_form_field.dart';
import 'package:flutter/material.dart';

class PatientSearchBar extends StatelessWidget {
  const PatientSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
