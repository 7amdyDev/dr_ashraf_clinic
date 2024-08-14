import 'package:dr_ashraf_clinic/model/appointment_model.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController {
  var appointmentApi = Get.find<AppointmentApi>();

  RxList<AppointmentModel> appointmentlst = <AppointmentModel>[].obs;
  RxList<AppointmentModel> patientAppointlst = <AppointmentModel>[].obs;
  RxList<AppointmentModel> appointListByDate = <AppointmentModel>[].obs;
  RxInt serviceId = 0.obs;
  RxBool paid = false.obs;
  RxBool appointmentsLoading = false.obs;

  Future<void> addAppointment(AppointmentModel appointment) async {
    // appointmentlst.add(appointment);
    // appointListByDate.clear();
    // getAppointsByDate();
    appointmentsLoading.value = true;
    try {
      var response = await appointmentApi.create(appointment);

      if (response.statusCode == 201 && response.body != null) {
        // expenseId.value = (response.body!.id!);
        // getExpensesList();
        print(response.body?.id);
      }
    } finally {
      appointmentsLoading.value = false;
    }
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

class AppointmentApi extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = 'http://localhost:8080';
    httpClient.defaultContentType = 'application/json; charset=UTF-8';
  }

  Future<Response<List<AppointmentModel>>> getAll() =>
      get('/appointments', decoder: AppointmentModel.listFromJson);

  Future<Response<AppointmentModel>> getById(int id) =>
      get('/appointments/$id', decoder: AppointmentModel.fromJson);

  Future<Response<List<AppointmentModel>>> getByDate(String dateTime) =>
      get('/appointments/date/$dateTime',
          decoder: AppointmentModel.listFromJson);

  Future<Response<AppointmentModel>> create(AppointmentModel appointment) =>
      post('/appointments', appointment.toJson(),
          decoder: AppointmentModel.fromJson);

  Future<Response<AppointmentModel>> update(AppointmentModel appointment) =>
      put('/appointments/${appointment.id}', appointment.toJson(),
          decoder: AppointmentModel.fromJson);

  Future<Response> remove(int id) => delete('/appointments/$id');
}
