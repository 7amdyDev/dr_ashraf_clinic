import 'package:dr_ashraf_clinic/model/patient_model.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:get/get.dart';

class PatientController extends GetxController {
  var patientApi = Get.find<PatientApi>();
  RxList<PatientModel> patientList = <PatientModel>[].obs;
  RxList<PatientModel> searchResult = <PatientModel>[].obs;
  RxList<PatientModel> getPatientData = <PatientModel>[].obs;

  RxInt patientId = 0.obs;
  RxBool isLoading = false.obs;

  void choosePatient(int id) {
    patientId.value = id;
  }

  Future<void> getPatientList() async {
    isLoading.value = true;
    try {
      var response = await patientApi.getAll();

      if (response.statusCode == 200 && response.body != null) {
        patientList.value = (response.body!);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addNewPatient(PatientModel patient) async {
    searchResult.clear();
    try {
      var response = await patientApi.create(patient);

      if (response.statusCode == 201 && response.body != null) {
        patientId.value = (response.body!.id!);
        searchResult.add(response.body!);
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
        searchResult.firstWhere((item) => item.id == patientId.value);

    if (patient.id != null) {
      return patient;
    } else {
      isLoading.value = true;
      try {
        var response = await patientApi.getById(patientId.value);

        if (response.statusCode == 200 && response.body != null) {
          patientId.value = (response.body!.id!);
          searchResult.add(response.body!);
        }
        return response.body!;
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<PatientModel> getPatientById(int id) async {
    isLoading.value = true;
    searchResult.clear();
    try {
      var response = await patientApi.getById(id);

      if (response.statusCode == 200 && response.body != null) {
        patientId.value = (response.body!.id!);
        searchResult.add(response.body!);
      }
      return response.body!;
    } finally {
      isLoading.value = false;
    }
  }

  void patientSearch({int? id, String? mobile, String? name}) async {
    searchResult.clear();
    if (id != null) {
      // for (var item in patientList) {
      //   if (item.id == id) searchResult.add(item);
      // }
      isLoading.value = true;
      try {
        var response = await patientApi.getById(id);

        if (response.statusCode == 200 && response.body != null) {
          // patientId.value = (response.body!.id!);

          searchResult.add(response.body!);
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
          // patientId.value = (response.body!.id!);

          searchResult.addAll(response.body!);
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
          // patientId.value = (response.body!.id!);

          searchResult.addAll(response.body!);
        }
      } finally {
        isLoading.value = false;
      }
    }
  }
}

class PatientApi extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = 'http://localhost:8080';
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
