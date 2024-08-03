import 'package:dr_ashraf_clinic/model/appointment_model.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController {
  RxList<AppointmentModel> appointmentlst = <AppointmentModel>[].obs;
  RxList<AppointmentModel> patientAppointlst = <AppointmentModel>[].obs;
  RxInt serviceId = 0.obs;
  RxBool paid = false.obs;
  void addAppointment(AppointmentModel appointment) {
    appointmentlst.add(appointment);
  }

  String getAppointmentDateById(int appId) {
    return appointmentlst.firstWhere((element) => element.id == appId).dateTime;
  }

  AppointmentModel getAppointmentById(int appId) {
    return appointmentlst.firstWhere((element) => element.id == appId);
  }

  int getAppointmentService(int appId) {
    return appointmentlst
        .firstWhere((element) => element.id == appId)
        .serviceId;
  }

  List<AppointmentModel> getPatientAppointment(int id) {
    patientAppointlst.clear();
    for (var item in appointmentlst) {
      if (item.patientId == id) {
        patientAppointlst.add(item);
      }
    }

    // sorting list in descending order
    if (patientAppointlst.isNotEmpty) {
      patientAppointlst.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    }

    return patientAppointlst;
  }
}
