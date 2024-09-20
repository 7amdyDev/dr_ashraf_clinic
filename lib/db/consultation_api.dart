import 'package:dr_ashraf_clinic/model/consultation_model.dart';
import 'package:get/get.dart';

class ConsultationApi extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = 'https://clinicnode.up.railway.app';
    httpClient.defaultContentType = 'application/json; charset=UTF-8';
  }

  Future<Response<ConsultationModel>> update(ConsultationModel consulation) =>
      put('/consultation/${consulation.id}', consulation.toMap(),
          decoder: ConsultationModel.fromJson);

  Future<Response<List<ConsultationModel>>> getConsultation() =>
      get('/consultation', decoder: ConsultationModel.listFromJson);

  Future<Response<List<ConsultationModel>>> getConsultationByPatientId(id) =>
      get('/consultation/patient/$id', decoder: ConsultationModel.listFromJson);

  Future<Response<ConsultationModel>> getConsultationByAppointmentId(id) =>
      get('/consultation/appointment/$id', decoder: ConsultationModel.fromJson);

  Future<Response<ConsultationModel>> getConsultationById(id) =>
      get('/consultation/$id', decoder: ConsultationModel.fromJson);

  Future<Response<List<SymptomsModel>>> getSymptomsByConsultId(id) =>
      get('/symptoms/consult/$id', decoder: SymptomsModel.listFromJson);

  Future<Response<List<DiagnosisModel>>> getDiagnosisByConsultId(id) =>
      get('/diagnosis/consult/$id', decoder: DiagnosisModel.listFromJson);

  Future<Response<List<PrescriptionModel>>> getPrescripByConsultId(id) =>
      get('/prescription/consult/$id', decoder: PrescriptionModel.listFromJson);

  Future<Response<SymptomsModel>> createSymptoms(SymptomsModel symptoms) =>
      post('/symptoms', symptoms.toMap(), decoder: SymptomsModel.fromJson);

  Future<Response<DiagnosisModel>> createDiagnosis(DiagnosisModel diagnosis) =>
      post('/diagnosis', diagnosis.toMap(), decoder: DiagnosisModel.fromJson);

  Future<Response<PrescriptionModel>> createPrescription(
          PrescriptionModel medicine) =>
      post('/prescription', medicine.toMap(),
          decoder: PrescriptionModel.fromJson);

  Future<Response> removeSymptoms(int id) => delete('/symptoms/$id');

  Future<Response> removeDiagnosis(int id) => delete('/diagnosis/$id');

  Future<Response> removePrescription(int id) => delete('/prescription/$id');
}
