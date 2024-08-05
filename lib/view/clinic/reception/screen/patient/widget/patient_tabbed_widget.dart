import 'package:dr_ashraf_clinic/controller/appointment_controller.dart';
import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/patient_finance.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/patient/widget/view_patient_card_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/patient_reservation_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientTabbedPage extends StatelessWidget {
  const PatientTabbedPage({super.key});

  @override
  Widget build(BuildContext context) {
    var patientController = Get.put(PatientController());
    var appointmentController = Get.put(AppointmentController());
    return Obx(() => DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: HColors.secondary,
            appBar: AppBar(
              toolbarHeight: 0,
              automaticallyImplyLeading: false,
              bottom: TabBar(
                tabs: [
                  Tab(text: 'patient_label2'.tr),
                  Tab(text: 'schedule_table_label'.tr),
                  Tab(text: 'patient_finance_label2'.tr),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                patientController.patientId.value != 0
                    ? SingleChildScrollView(
                        child: ViewPatientCardWidget(
                            patientRecord: patientController.getPatient()),
                      )
                    : const Center(),
                patientController.patientId.value != 0
                    ? SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: HSizes.spaceBtwSections),
                          child: PatientReservationTable(
                              searchResult:
                                  appointmentController.patientAppointlst),
                        ),
                      )
                    : const Center(),
                patientController.patientId.value != 0
                    ? const PatientFinance(
                        show: false,
                      )
                    : const Center(),
              ],
            ),
          ),
        ));
  }
}
