import 'package:dr_ashraf_clinic/db/doctor_info_api.dart'; // Make sure this path is correct
import 'package:dr_ashraf_clinic/model/reservation_limit_model.dart';
import 'package:get/get.dart';

class ReservationLimitController extends GetxController {
  // Use Get.find() to get the instance of your API service
  final DoctorInfoApi _apiService = Get.find<DoctorInfoApi>();

  var reservationLimit = Rx<ReservationLimit?>(null);
  var isLoading = true.obs;
  var errorMessage = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchReservationLimit();
  }

  Future<void> fetchReservationLimit() async {
    isLoading.value = true;
    try {
      reservationLimit.value = await _apiService.fetchReservation();
    } catch (e) {
      reservationLimit.value = null;
    }
    isLoading.value = false;
  }
}
