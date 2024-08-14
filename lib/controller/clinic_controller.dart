import 'package:dr_ashraf_clinic/model/online_reserv_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/api_constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClinicController extends GetxController {
  RxBool isCollapsed = true.obs;
  RxList<OnlineReservModel> onlineReservData = <OnlineReservModel>[].obs;
  RxInt receptionPageIndex = 0.obs;
  RxInt doctorPageIndex = 0.obs;
  final database = FirebaseDatabase.instance;

  @override
  void onInit() {
    super.onInit();
    database.databaseURL = dBUrl;
    final DatabaseReference reference = database.ref().child('Appointment');

    reference.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map?;
      onlineReservData.clear();
      if (data != null) {
        data.forEach((key, value) {
          onlineReservData.add(OnlineReservModel(
              id: key,
              name: value["name"],
              mobile: value["mobile"],
              dateTime: value["date"]));
        });
      }
    });
  }

  void updateCollapsed(bool collapsed) {
    isCollapsed.value = collapsed;
  }

  void createOnlineReserv(OnlineReservModel model) {
    database.databaseURL = dBUrl;
    final DatabaseReference reference = database.ref().child('Appointment');

    final newAppointRef =
        reference.push(); // Create a new reference for a new appointment
    newAppointRef.set({
      'name': model.name,
      'date': model.dateTime,
      'mobile': model.mobile,
    }).then((_) {
      Get.dialog(
        AlertDialog(
          title: const Center(child: Text('Success')),
          content: Text(
            'appointment_success'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          alignment: Alignment.center,
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Center(child: Text('OK')),
            ),
          ],
        ),
      );
    }).catchError((error) {
      //debugPrint('Error adding user: $error');
    });
  }

  void deleteOnlineReserv(String appointId) {
    database.databaseURL = dBUrl;

    final DatabaseReference reference =
        database.ref().child('Appointment/$appointId');
    reference.remove().then((_) {
      // debugPrint('User removed successfully');
      // Get.snackbar('Title', 'Checked', snackPosition: SnackPosition.BOTTOM);
    }).catchError((error) {
      //  debugPrint('Error removing user: $error');
    });
  }
}
