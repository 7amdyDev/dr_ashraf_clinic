import 'package:get/get.dart';

class ClinicController extends GetxController {
  RxBool isCollapsed = true.obs;
  RxBool show = false.obs;

  RxInt receptionPageIndex = 0.obs;
  RxList<String> patientSearchResult = <String>[].obs;
  void updateCollapsed(bool collapsed) {
    isCollapsed.value = collapsed;
  }
}
