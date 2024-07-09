import 'package:dr_ashraf_clinic/model/clinic_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/patient_reservation_card.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/patient_reservation_table.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/search_list_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClinicController());
    TextEditingController dateController = TextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: HSizes.spaceBtwItems,
        ),
        const PageLabelWidget(
          text: 'appointment_page_label',
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
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Obx(
                  () => PatientReservationCardWidget(
                    dateController: dateController,
                    show: controller.show.value,
                    id: 1,
                    name: 'دعاء منذر محمد عبدالمجيد',
                    telephone: '01008169644',
                  ),
                ),
                Obx(() => controller.show.value
                    ? Column(
                        children: [
                          const SizedBox(
                            height: HSizes.spaceBtwItems,
                          ),
                          Text(
                            'schedule_table_label'.tr,
                            style: GoogleFonts.cairo(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          PatientReservationTable(
                              show: controller.show.value,
                              searchResult:
                                  controller.patientSearchResult.toList()),
                        ],
                      )
                    : const SizedBox()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
