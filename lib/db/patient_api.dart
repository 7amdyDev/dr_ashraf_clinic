import 'package:dr_ashraf_clinic/model/patient_model.dart';
import 'package:get/get.dart';

class PatientApi extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = 'https://clinicnode.up.railway.app';
    //httpClient.baseUrl = 'http://localhost:8080';

    httpClient.defaultContentType = 'application/json; charset=UTF-8';
  }

  Future<Response<List<PatientModel>>> getAll() =>
      get('/patients', decoder: PatientModel.listFromJson);

  Future<Response<PatientModel>> getById(int id) =>
      get('/patients/$id', decoder: PatientModel.fromJson);

  Future<Response<List<PatientModel>>> getByName(String name) =>
      get('/patients/name/$name', decoder: PatientModel.listFromJson);

  Future<Response<List<PatientModel>>> getByMobile(String mobile) =>
      get('/patients/mobile/$mobile', decoder: PatientModel.listFromJson);

  Future<Response<PatientModel>> create(PatientModel patient) =>
      post('/patients', patient.toJson(), decoder: PatientModel.fromJson);

  Future<Response<PatientModel>> update(PatientModel patient) =>
      put('/patients/${patient.id}', patient.toJson(),
          decoder: PatientModel.fromJson);

  Future<Response> remove(int id) => delete('/patients/$id');
}
