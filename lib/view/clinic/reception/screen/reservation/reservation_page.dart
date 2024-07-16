import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/patient_reservation_card.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/patient_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PatientController());
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
        const PatientSearchBar(),
        Expanded(
          child: SingleChildScrollView(
            child: Obx(() => controller.patientId.value != 0
                ? Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Obx(() {
                        return PatientReservationCardWidget(
                          dateController: dateController,
                          id: controller.patientId.value,
                          name: controller.getPatient().name,
                          telephone: controller.getPatient().mobile,
                        );
                      }),
                      Column(
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
                          // PatientReservationTable(
                          //     show: controller.patientId.value > 0 ? true : false,
                          //     searchResult:
                          //         controller.patientList.toList()),
                        ],
                      ),
                    ],
                  )
                : const SizedBox()),
          ),
        ),
      ],
    );
  }
}
