import 'package:dr_ashraf_clinic/controller/appointment_controller.dart';
import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/patient_reservation_card.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/patient_reservation_table.dart';
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
    final appointController = Get.put(AppointmentController());
    appointController.getPatientAppointment(controller.patientId.value);
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
          child: Obx(() => !controller.isLoading.value
              ? FutureBuilder(
                  future: controller.getPatient(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            PatientReservationCardWidget(
                                dateController: dateController,
                                id: controller.patientId.value,
                                name: snapshot.data!.name,
                                mobile: snapshot.data!.mobile),
                            Column(
                              children: [
                                Text(
                                  'schedule_table_label'.tr,
                                  style: GoogleFonts.cairo(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                PatientReservationTable(
                                  searchResult:
                                      appointController.getPatientAppointment(
                                          controller.patientId.value),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  })
              : Container()),
        )
      ],
    );
  }
}
