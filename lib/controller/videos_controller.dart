import 'package:dr_ashraf_clinic/db/doctor_info_api.dart';
import 'package:dr_ashraf_clinic/model/video_model.dart';
import 'package:get/get.dart'; // Import GetX

class VideoController extends GetxController {
  final DoctorInfoApi _apiService = Get.find<DoctorInfoApi>();

  var videos = <Video>[].obs;
  var isLoading = true.obs;
  var errorMessage = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchVideos(); // Fetch data when the controller is initialized
  }

  // Fetches videos and updates the state.
  Future<void> fetchVideos() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      final fetchedVideos = await _apiService.fetchVideos();
      videos.assignAll(fetchedVideos);
    } catch (e) {
      errorMessage.value = e.toString();
      videos.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
