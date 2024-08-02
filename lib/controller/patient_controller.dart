import 'package:dr_ashraf_clinic/model/patient_model.dart';
import 'package:get/get.dart';

class PatientController extends GetxController {
  RxList<PatientModel> patientList = <PatientModel>[].obs;
  RxList<PatientModel> searchResult = <PatientModel>[].obs;
  RxInt patientId = 0.obs;

  void choosePatient(int id) {
    patientId.value = id;
  }

  void addNewPatient(PatientModel patient) {
    patientList.add(patient);
  }

  void updatePatient(PatientModel patient) {
    int index = patientList.indexWhere((element) => element.id == patient.id);
    patientList[index] = patient;
  }

  PatientModel getPatient() {
    return patientList.firstWhere((element) => element.id == patientId.value);
  }

  PatientModel getPatientById(int id) {
    return patientList.firstWhere((element) => element.id == id);
  }

  void patientSearch({int? id, String? mobile, String? name}) {
    searchResult.clear();

    if (id != null) {
      for (var item in patientList) {
        if (item.id == id) searchResult.add(item);
      }
    }
    if (mobile != null) {
      for (var item in patientList) {
        if (item.mobile.contains(mobile)) searchResult.add(item);
      }
    }
    if (name != null) {
      for (var item in patientList) {
        if (item.name.contains(name)) searchResult.add(item);
      }
    }
  }
}
