import 'package:dr_ashraf_clinic/controller/appointment_controller.dart';
import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/previous_check.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/patient_finance.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/patient/widget/view_patient_card_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/patient_reservation_table.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorTabbedPage extends StatelessWidget {
  const DoctorTabbedPage({super.key});

  @override
  Widget build(BuildContext context) {
    var patientController = Get.put(PatientController());
    var appointmentController = Get.put(AppointmentController());
    return Obx(() => DefaultTabController(
          length: 4,
          child: Scaffold(
              backgroundColor: HColors.secondary,
              appBar: AppBar(
                toolbarHeight: 0,
                automaticallyImplyLeading: false,
                bottom: TabBar(
                  labelColor: Colors.red[600],
                  tabs: const [
                    Tab(
                      child: PageLabelWidget(
                        text: 'patient_label2',
                        fontSize: 22,
                      ),
                    ),
                    Tab(
                      child: PageLabelWidget(
                        text: 'schedule_table_label',
                        fontSize: 22,
                      ),
                    ),
                    Tab(
                      child: PageLabelWidget(
                        text: 'patient_finance_label2',
                        fontSize: 22,
                      ),
                    ),
                    Tab(
                      child: PageLabelWidget(
                        text: 'previous_check_label',
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              body: FutureBuilder(
                  future: patientController.getPatient(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null) {
                      appointmentController
                          .getPatientAppointment(snapshot.data!.id!);

                      return TabBarView(
                        children: [
                          patientController.patientId.value != 0
                              ? SingleChildScrollView(
                                  primary: true,
                                  child: ViewPatientCardWidget(
                                      patientRecord: snapshot.data!),
                                )
                              : const Center(),
                          patientController.patientId.value != 0
                              ? SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: HSizes.spaceBtwSections),
                                    child: PatientReservationTable(
                                        searchResult: appointmentController
                                            .patientAppointlst),
                                  ),
                                )
                              : const Center(),
                          patientController.patientId.value != 0
                              ? PatientFinance(
                                  show: false,
                                )
                              : const Center(),
                          patientController.patientId.value != 0
                              ? PreviousCheck()
                              : const Center(),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  })),
        ));
  }
}
