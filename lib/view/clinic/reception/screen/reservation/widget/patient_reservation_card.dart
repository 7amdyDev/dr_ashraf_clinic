import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/patient_data_chip.dart';
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
    this.show = false,
  });

  final TextEditingController dateController;
  final int id;
  final String name;
  final String telephone;
  final bool show;
  @override
  Widget build(BuildContext context) {
    return show
        ? Card(
            child: Padding(
                padding: const EdgeInsets.all(HSizes.defaultSpace),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DataTextWidget(
                          label: 'id_no_label'.tr,
                          enable: false,
                          value: id.toString(),
                        ),
                        DataTextWidget(
                          label: 'name_label'.tr,
                          value: name,
                          enable: false,
                        ),
                        DataTextWidget(
                          label: 'telephone_label'.tr,
                          value: telephone,
                          enable: false,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DataTextWidget(
                          label: 'date_label'.tr,
                          child: PickDateWidget(
                              width: 200, dateController: dateController),
                        ),
                        DataTextWidget(
                          label: 'service_type_label'.tr,
                          child: ServiceTypeDropDownMenu(
                            onSelected: (value) {},
                          ),
                        ),
                        DataTextWidget(
                            label: 'paid_label'.tr,
                            child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TableCheckBoxWidget()))
                      ],
                    ),
                    HFilledButton(
                        text: 'save_button', fontSize: 22, onPressed: () {})
                  ],
                )),
          )
        : const SizedBox();
  }
}
