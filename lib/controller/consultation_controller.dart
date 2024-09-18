import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/db/consultation_api.dart';
import 'package:dr_ashraf_clinic/model/consultation_model.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:get/get.dart';

class ConsultationController extends GetxController {
  final _consultationApi = Get.find<ConsultationApi>();
  final _patientController = Get.find<PatientController>();
  RxList<ConsultationModel> consultationList = <ConsultationModel>[].obs;
  RxList<SymptomsModel> symptomsList = <SymptomsModel>[].obs;
  RxList<DiagnosisModel> diagnosisList = <DiagnosisModel>[].obs;
  RxList<PrescriptionModel> prescriptionList = <PrescriptionModel>[].obs;
  RxList<SymptomsModel> prvCheckSymptomsList = <SymptomsModel>[].obs;
  RxList<DiagnosisModel> prvCheckDiagnosisList = <DiagnosisModel>[].obs;
  RxList<PrescriptionModel> prvCheckPrescriptionList =
      <PrescriptionModel>[].obs;
  RxInt patientId = 0.obs;
  RxInt consultId = 0.obs;
  RxInt appointId = 0.obs;
  RxBool consultLoading = false.obs;

  @override
  void onInit() {
    getPatientId();
    super.onInit();
  }

  void getPatientId() {
    ever(_patientController.patientId, (value) {
      patientId.value = value;
    });
  }

  void clearPrvConsultAllData() {
    prvCheckSymptomsList.clear();
    prvCheckDiagnosisList.clear();
    prvCheckPrescriptionList.clear();
  }

  void getConsultAllData({
    int? id,
  }) {
    if (id == null) {
      getSymptomsList(consultId.value);
      getDiagnosisList(consultId.value);
      getPrescriptionList(consultId.value);
    } else {
      getSymptomsList(id, previous: true);
      getDiagnosisList(id, previous: true);
      getPrescriptionList(id, previous: true);
    }
  }

  Future<void> getConsultIdByAppointId(int appointId) async {
    consultLoading.value = true;
    try {
      var response =
          await _consultationApi.getConsultationByAppointmentId(appointId);

      if (response.statusCode == 200 && response.body != null) {
        consultId.value = response.body!.id!;
        getConsultAllData();
      }
    } finally {
      consultLoading.value = false;
    }
  }

  Future<void> updateConsultation(ConsultationModel consult) async {
    try {
      var response = await _consultationApi.update(consult);

      if (response.statusCode == 201 && response.body != null) {
        HelperFunctions.showSnackBar('Record Updated Successfully');
        getConsultationByPatientId(consult.patientId);
      }
    } finally {}
  }

  Future<ConsultationModel> getConsultById(int id) async {
    ConsultationModel consult =
        consultationList.firstWhere((element) => element.id == id);
    if (consult.id != null) {
      getConsultAllData();
      return consult;
    } else {
      consultLoading.value = true;
      try {
        var response = await _consultationApi.getConsultationById(id);

        if (response.statusCode == 200 && response.body != null) {
          consultationList.add(response.body!);
          getConsultAllData();
        }
        return response.body!;
      } finally {
        consultLoading.value = false;
      }
    }
  }

  Future<void> getConsultationByPatientId(int patientId) async {
    consultLoading.value = true;
    consultationList.clear();
    try {
      var response =
          await _consultationApi.getConsultationByPatientId(patientId);

      if (response.statusCode == 200 && response.body != null) {
        consultationList.value = response.body!;
      }
    } finally {
      consultLoading.value = false;
    }
  }

  Future<void> getSymptomsList(int id, {bool previous = false}) async {
    consultLoading.value = true;
    (previous) ? prvCheckSymptomsList.clear() : symptomsList.clear();
    try {
      var response = await _consultationApi.getSymptomsByConsultId(id);

      if (response.statusCode == 200 && response.body != null) {
        (previous)
            ? prvCheckSymptomsList.value = response.body!
            : symptomsList.value = response.body!;
      }
    } finally {
      consultLoading.value = false;
    }
  }

  Future<void> addSymptoms(SymptomsModel symptoms) async {
    consultLoading.value = true;

    try {
      var response = await _consultationApi.createSymptoms(symptoms);
      if (response.statusCode == 201) {
        getSymptomsList(consultId.value);
        HelperFunctions.showSnackBar('added');
      }
    } finally {
      consultLoading.value = false;
    }
  }

  Future<void> addDiagnosis(DiagnosisModel diagnosis) async {
    consultLoading.value = true;

    try {
      var response = await _consultationApi.createDiagnosis(diagnosis);
      if (response.statusCode == 201) {
        getDiagnosisList(consultId.value);
        HelperFunctions.showSnackBar('added');
      }
    } finally {
      consultLoading.value = false;
    }
  }

  Future<void> addPrescription(PrescriptionModel medicine) async {
    consultLoading.value = true;

    try {
      var response = await _consultationApi.createPrescription(medicine);
      if (response.statusCode == 201) {
        getPrescriptionList(consultId.value);
        HelperFunctions.showSnackBar('added');
      }
    } finally {
      consultLoading.value = false;
    }
  }

  Future<void> deleteSymptoms(int id) async {
    consultLoading.value = true;

    try {
      var response = await _consultationApi.removeSymptoms(id);
      if (response.statusCode == 200) {
        getSymptomsList(consultId.value);
        HelperFunctions.showSnackBar('Deleted');
      }
    } finally {
      consultLoading.value = false;
    }
  }

  Future<void> deleteDiagnosis(int id) async {
    consultLoading.value = true;

    try {
      var response = await _consultationApi.removeDiagnosis(id);
      if (response.statusCode == 200) {
        getDiagnosisList(consultId.value);
        HelperFunctions.showSnackBar('Deleted');
      }
    } finally {
      consultLoading.value = false;
    }
  }

  Future<void> deletePrescription(int id) async {
    consultLoading.value = true;

    try {
      var response = await _consultationApi.removePrescription(id);
      if (response.statusCode == 200) {
        getPrescriptionList(consultId.value);
        HelperFunctions.showSnackBar('Deleted');
      }
    } finally {
      consultLoading.value = false;
    }
  }

  Future<void> getDiagnosisList(int id, {bool previous = false}) async {
    consultLoading.value = true;
    (previous) ? prvCheckDiagnosisList.clear() : diagnosisList.clear();
    try {
      var response = await _consultationApi.getDiagnosisByConsultId(id);

      if (response.statusCode == 200 && response.body != null) {
        (previous)
            ? prvCheckDiagnosisList.value = response.body!
            : diagnosisList.value = response.body!;
      }
    } finally {
      consultLoading.value = false;
    }
  }

  Future<void> getPrescriptionList(int id, {bool previous = false}) async {
    consultLoading.value = true;
    (previous) ? prvCheckPrescriptionList.clear() : prescriptionList.clear();
    try {
      var response = await _consultationApi.getPrescripByConsultId(id);

      if (response.statusCode == 200 && response.body != null) {
        (previous)
            ? prvCheckPrescriptionList.value = response.body!
            : prescriptionList.value = response.body!;
      }
    } finally {
      consultLoading.value = false;
    }
  }
}
