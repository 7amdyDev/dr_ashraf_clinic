import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/data_text_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/reservation_dropdownmenu_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/checkbox_table_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/pick_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class PatientReservationCardWidget extends StatelessWidget {
  const PatientReservationCardWidget({
    super.key,
    required this.dateController,
    required this.id,
    required this.name,
    required this.telephone,
  });

  final TextEditingController dateController;
  final int? id;
  final String? name;
  final String? telephone;
  @override
  Widget build(BuildContext context) {
    double width = HelperFunctions.clinicPagesWidth();

    return Card(
      child: Padding(
          padding: const EdgeInsets.all(HSizes.defaultSpace),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DataTextWidget(
                    label: 'id_no_label'.tr,
                    enable: false,
                    width: width / 6,
                    value: id.toString(),
                  ),
                  DataTextWidget(
                    label: 'name_label'.tr,
                    value: name,
                    width: width / 4,
                    textFontSize: 16,
                    enable: false,
                  ),
                  DataTextWidget(
                    label: 'telephone_label'.tr,
                    value: telephone,
                    width: width / 4,
                    enable: false,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DataTextWidget(
                    label: 'service_type_label'.tr,
                    width: width / 6,
                    child: ServiceTypeDropDownMenu(
                      onSelected: (value) {},
                    ),
                  ),
                  DataTextWidget(
                    width: width / 4,
                    label: 'date_label'.tr,
                    child: PickDateWidget(
                      width: width / 4,
                      dateController: dateController,
                    ),
                  ),
                  DataTextWidget(
                      label: 'paid_label'.tr,
                      width: width / 4,
                      child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TableCheckBoxWidget()))
                ],
              ),
              HFilledButton(text: 'save_button', fontSize: 22, onPressed: () {})
            ],
          )),
    );
  }
}
