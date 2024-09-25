import 'package:dr_ashraf_clinic/model/appointment_model.dart';
import 'package:get/get.dart';

class AppointmentApi extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = 'https://clinicnode.up.railway.app';
    //  httpClient.baseUrl = 'http://localhost:8080';
    httpClient.defaultContentType = 'application/json; charset=UTF-8';
  }

  Future<Response<List<AppointmentModel>>> getAll() =>
      get('/appointments', decoder: AppointmentModel.listFromJson);

  Future<Response<AppointmentModel>> getById(int id) =>
      get('/appointments/$id', decoder: AppointmentModel.fromJson);

  // Future<Response<AppointmentModel>> getByIdService(int id, int serviceId) =>
  //     get('/appointments/service/$id/$serviceId',
  //         decoder: AppointmentModel.fromJson);

  Future<Response<List<AppointmentModel>>> getByDate(DateTime date) =>
      get('/appointments/date/$date', decoder: AppointmentModel.listFromJson);

  Future<Response<List<AppointmentModel>>> getByPatientId(int id) =>
      get('/appointments/patient/$id', decoder: AppointmentModel.listFromJson);

  Future<Response<AppointmentModel>> create(AppointmentModel appointment) =>
      post('/appointments', appointment.toJson(),
          decoder: AppointmentModel.fromJson);

  Future<Response<AppointmentModel>> update(AppointmentModel appointment) =>
      put('/appointments/${appointment.id}', appointment.toJson(),
          decoder: AppointmentModel.fromJson);

  Future<Response> remove(int id) => delete('/appointments/$id');
}
