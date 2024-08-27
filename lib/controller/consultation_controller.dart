import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/db/consultation_api.dart';
import 'package:dr_ashraf_clinic/model/consultation_model.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:get/get.dart';

class ConsultationController extends GetxController {
  var consultationApi = Get.find<ConsultationApi>();
  var patientController = Get.find<PatientController>();
  RxList<ConsultationModel> consultationList = <ConsultationModel>[].obs;
  RxList<SymptomsModel> symptomsList = <SymptomsModel>[].obs;
  RxList<DiagnosisModel> diagnosisList = <DiagnosisModel>[].obs;
  RxList<PrescriptionModel> prescriptionList = <PrescriptionModel>[].obs;
  RxInt patientId = 0.obs;
  RxInt consultId = 0.obs;
  RxBool consultLoading = false.obs;

  @override
  void onInit() {
    getPatientId();
    super.onInit();
  }

  void getPatientId() {
    ever(patientController.patientId, (value) {
      patientId.value = value;
    });
  }

  void getConsultAllData() {
    getSymptomsList();
    getDiagnosisList();
    getPrescriptionList();
  }

  Future<void> getConsultIdByAppointId(int appointId) async {
    consultLoading.value = true;
    try {
      var response =
          await consultationApi.getConsultationByAppointmentId(appointId);

      if (response.statusCode == 200 && response.body != null) {
        consultId.value = response.body!.id!;
      }
    } finally {
      consultLoading.value = false;
    }
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
        var response = await consultationApi.getConsultationById(id);

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
          await consultationApi.getConsultationByPatientId(patientId);

      if (response.statusCode == 200 && response.body != null) {
        consultationList.value = response.body!;
      }
    } finally {
      consultLoading.value = false;
    }
  }

  Future<void> getSymptomsList() async {
    consultLoading.value = true;
    symptomsList.clear();
    try {
      var response =
          await consultationApi.getSymptomsByConsultId(consultId.value);

      if (response.statusCode == 200 && response.body != null) {
        symptomsList.value = response.body!;
      }
    } finally {
      consultLoading.value = false;
    }
  }

  Future<void> addSymptoms(SymptomsModel symptoms) async {
    consultLoading.value = true;

    try {
      var response = await consultationApi.createSymptoms(symptoms);
      if (response.statusCode == 201) {
        getSymptomsList();
        HelperFunctions.showSnackBar('added');
      }
    } finally {
      consultLoading.value = false;
    }
  }

  Future<void> addDiagnosis(DiagnosisModel diagnosis) async {
    consultLoading.value = true;

    try {
      var response = await consultationApi.createDiagnosis(diagnosis);
      if (response.statusCode == 201) {
        getDiagnosisList();
        HelperFunctions.showSnackBar('added');
      }
    } finally {
      consultLoading.value = false;
    }
  }

  Future<void> addPrescription(PrescriptionModel medicine) async {
    consultLoading.value = true;

    try {
      var response = await consultationApi.createPrescription(medicine);
      if (response.statusCode == 201) {
        getPrescriptionList();
        HelperFunctions.showSnackBar('added');
      }
    } finally {
      consultLoading.value = false;
    }
  }

  Future<void> deleteSymptoms(int id) async {
    consultLoading.value = true;

    try {
      var response = await consultationApi.removeSymptoms(id);
      if (response.statusCode == 200) {
        getSymptomsList();
        HelperFunctions.showSnackBar('Deleted');
      }
    } finally {
      consultLoading.value = false;
    }
  }

  Future<void> deleteDiagnosis(int id) async {
    consultLoading.value = true;

    try {
      var response = await consultationApi.removeDiagnosis(id);
      if (response.statusCode == 200) {
        getDiagnosisList();
        HelperFunctions.showSnackBar('Deleted');
      }
    } finally {
      consultLoading.value = false;
    }
  }

  Future<void> deletePrescription(int id) async {
    consultLoading.value = true;

    try {
      var response = await consultationApi.removePrescription(id);
      if (response.statusCode == 200) {
        getPrescriptionList();
        HelperFunctions.showSnackBar('Deleted');
      }
    } finally {
      consultLoading.value = false;
    }
  }

  Future<void> getDiagnosisList() async {
    consultLoading.value = true;
    diagnosisList.clear();
    try {
      var response =
          await consultationApi.getDiagnosisByConsultId(consultId.value);

      if (response.statusCode == 200 && response.body != null) {
        diagnosisList.value = response.body!;
      }
    } finally {
      consultLoading.value = false;
    }
  }

  Future<void> getPrescriptionList() async {
    consultLoading.value = true;
    prescriptionList.clear();
    try {
      var response =
          await consultationApi.getPrescripByConsultId(consultId.value);

      if (response.statusCode == 200 && response.body != null) {
        prescriptionList.value = response.body!;
      }
    } finally {
      consultLoading.value = false;
    }
  }
}
