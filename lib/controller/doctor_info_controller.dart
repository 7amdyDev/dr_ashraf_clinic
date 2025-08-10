import 'package:dr_ashraf_clinic/db/doctor_info_api.dart';
import 'package:dr_ashraf_clinic/model/doctor_model.dart';
import 'package:get/get.dart';

class DoctorController extends GetxController with StateMixin<Doctor> {
  // Inject the ApiService
  final DoctorInfoApi _apiService = Get.find<DoctorInfoApi>();

  @override
  void onInit() {
    super.onInit();
    // Fetch doctor profile when the controller is initialized
    fetchDoctorProfile();
  }

  // Method to fetch the doctor's data and update the state
  void fetchDoctorProfile() async {
    change(null, status: RxStatus.loading());

    try {
      final Doctor doctor = await _apiService.getDoctorProfile();
      // On success, update the state with the doctor's data
      change(doctor, status: RxStatus.success());
    } catch (e) {
      // On error, update the state with an error message
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
