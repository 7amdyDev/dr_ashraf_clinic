import 'package:dr_ashraf_clinic/model/online_reserv_model.dart';
import 'package:get/get.dart';

class ClinicController extends GetxController {
  RxBool isCollapsed = true.obs;
  RxInt recordIndex = 0.obs;

  RxList<OnlineReservModel> onlineReservData = <OnlineReservModel>[].obs;
  RxInt receptionPageIndex = 0.obs;
  RxList<String> patientSearchResult = <String>[].obs;
  void updateCollapsed(bool collapsed) {
    isCollapsed.value = collapsed;
  }
}
