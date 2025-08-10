import 'package:dr_ashraf_clinic/db/doctor_info_api.dart';
import 'package:dr_ashraf_clinic/model/social_button_model.dart';
import 'package:get/get.dart';

class SocialButtonsController extends GetxController {
  var buttons = <SocialButton>[].obs;
  var isLoading = false.obs;
  final DoctorInfoApi _apiService = Get.find<DoctorInfoApi>();
  @override
  void onInit() {
    super.onInit();

    fetchButtons();
  }

  void fetchButtons() async {
    isLoading.value = true;
    try {
      buttons.value = await _apiService.getSocialButtons();
    } catch (e) {
      buttons.value = [];
    }
    isLoading.value = false;
  }
}
