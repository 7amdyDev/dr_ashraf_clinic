import 'package:get/get.dart';

class ClinicController extends GetxController {
  RxBool isCollapsed = true.obs;

  void updateCollapsed(bool collapsed) {
    isCollapsed.value = collapsed;
  }
}
