import 'package:dr_ashraf_clinic/model/appointment_model.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController {
  RxList<AppointmentModel> appointmentlst = <AppointmentModel>[].obs;
  RxList<AppointmentModel> patientAppointlst = <AppointmentModel>[].obs;
  RxList<AppointmentModel> appointListByDate = <AppointmentModel>[].obs;
  RxInt serviceId = 0.obs;
  RxBool paid = false.obs;

  void addAppointment(AppointmentModel appointment) {
    appointmentlst.add(appointment);
    appointListByDate.clear();
    getAppointsByDate();
  }

  @override
  void onInit() {
    appointListByDate.clear();
    getAppointsByDate();
    super.onInit();
  }

  void getAppointsByDate({String? date}) {
    appointListByDate.clear();
    if (date == null) {
      for (var record in appointmentlst) {
        if (record.dateTime == HFormatter.formatDate(DateTime.now())) {
          appointListByDate.add(record);
        }
      }
    } else {
      for (var record in appointmentlst) {
        if (record.dateTime == date) {
          appointListByDate.add(record);
        }
      }
    }
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
