import 'package:dr_ashraf_clinic/db/patient_api.dart';
import 'package:dr_ashraf_clinic/model/patient_model.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:get/get.dart';

class PatientController extends GetxController {
  var patientApi = Get.find<PatientApi>();
  // RxList<PatientModel> patientList = <PatientModel>[].obs;
  RxList<PatientModel> patientList = <PatientModel>[].obs;
  // RxList<PatientModel> getPatientData = <PatientModel>[].obs;
  RxInt patientId = 0.obs;
  RxBool isLoading = false.obs;

  void choosePatient(int id) {
    patientId.value = id;
  }

  Future<void> addNewPatient(PatientModel patient) async {
    patientList.clear();
    try {
      var response = await patientApi.create(patient);

      if (response.statusCode == 201 && response.body != null) {
        patientId.value = (response.body!.id!);
        patientList.add(response.body!);
        HelperFunctions.showSnackBar('Patient Created Successfully');
      }
    } finally {}
  }

  Future<void> updatePatient(PatientModel patient) async {
    try {
      var response = await patientApi.update(patient);

      if (response.statusCode == 201 && response.body != null) {
        patientId.value = (response.body!.id!);
        HelperFunctions.showSnackBar('Patient Updated Successfully');
      }
    } finally {}
  }

  Future<PatientModel> getPatient() async {
    PatientModel patient =
        patientList.firstWhere((item) => item.id == patientId.value);

    if (patient.id != null) {
      return patient;
    } else {
      isLoading.value = true;
      try {
        var response = await patientApi.getById(patientId.value);

        if (response.statusCode == 200 && response.body != null) {
          // patientId.value = (response.body!.id!);
          patientList.add(response.body!);
        }
        return response.body!;
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<PatientModel> getPatientById(int id) async {
    isLoading.value = true;
    patientList.clear();
    try {
      var response = await patientApi.getById(id);

      if (response.statusCode == 200 && response.body != null) {
        patientId.value = (response.body!.id!);
        patientList.add(response.body!);
      }
      return response.body!;
    } finally {
      isLoading.value = false;
    }
  }

  void patientSearch({int? id, String? mobile, String? name}) async {
    if (id != null) {
      isLoading.value = true;
      try {
        var response = await patientApi.getById(id);

        if (response.statusCode == 200 && response.body != null) {
          // patientId.value = (response.body!.id!);
          patientList.clear();
          patientList.add(response.body!);
        }
      } finally {
        isLoading.value = false;
      }
    }
    if (mobile != null) {
      isLoading.value = true;
      var mobileNo = HFormatter.convertArabicToEnglishNumbers(mobile);
      try {
        var response = await patientApi.getByMobile(mobileNo);

        if (response.statusCode == 200 && response.body != null) {
          patientList.clear();

          patientList.addAll(response.body!);
        }
      } finally {
        isLoading.value = false;
      }
    }
    if (name != null) {
      isLoading.value = true;
      try {
        var response = await patientApi.getByName(name);

        if (response.statusCode == 200 && response.body != null) {
          patientList.clear();

          patientList.addAll(response.body!);
        }
      } finally {
        isLoading.value = false;
      }
    }
  }
}
