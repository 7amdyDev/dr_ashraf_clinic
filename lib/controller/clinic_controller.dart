import 'package:dr_ashraf_clinic/controller/medicines.dart';
import 'package:dr_ashraf_clinic/db/clinic_api.dart';
import 'package:dr_ashraf_clinic/model/clinic_models.dart';
import 'package:dr_ashraf_clinic/model/consultation_model.dart';
import 'package:dr_ashraf_clinic/model/online_reserv_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/api_constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClinicController extends GetxController {
  final _clinicApi = Get.find<ClinicApi>();
  RxList<OnlineReservModel> onlineReservData = <OnlineReservModel>[].obs;
  RxInt pageIndex = 0.obs;
  RxList<ServicesId> servicesId = <ServicesId>[].obs;
  RxList<AccountsId> expensesId = <AccountsId>[].obs;
  RxList<Fee> feeList = <Fee>[].obs;
  RxList<ClinicId> clinicBranches = <ClinicId>[].obs;
  RxInt clinicId = 1.obs;
  RxList<MedicineModel> dbMedicineSearch = <MedicineModel>[].obs;
  final database = FirebaseDatabase.instance;

  @override
  void onInit() {
    super.onInit();
    getClinicData();
    //  getOnlineReservationData();
  }

  void getOnlineReservationData() {
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

  void searchDatabase(String query) async {
    if (query.isEmpty) {
      dbMedicineSearch.clear();
      return;
    }
    database.databaseURL = dBUrl;
    final DatabaseReference dbRef = database.ref().child('Medicines');

    final snapshot = await dbRef.once();
    final data = snapshot.snapshot.value as Map<dynamic, dynamic>?;

    if (data != null) {
      dbMedicineSearch.clear();
      data.forEach((key, value) {
        if (value['name'].toLowerCase().contains(query)) {
          dbMedicineSearch.add(MedicineModel(
            name: value["name"],
          ));
        }
      });
    }
  }

  String getClinicBranchName({int? clinicBranchId}) {
    if (clinicBranches.isNotEmpty) {
      if (clinicBranchId != null) {
        return clinicBranches
            .firstWhere((clinic) => clinic.id == clinicBranchId)
            .branch
            .tr;
      }
      return clinicBranches
          .firstWhere((clinic) => clinic.id == clinicId.value)
          .branch
          .tr;
    } else {
      return 'Clinics';
    }
  }

  Future<void> getClinicData() async {
    try {
      var response = await _clinicApi.getClinicBranches();
      if (response.statusCode == 200 && response.body != null) {
        clinicBranches.addAll(response.body!);
      }
    } finally {}
    try {
      var response = await _clinicApi.getServices();

      if (response.statusCode == 200 && response.body != null) {
        servicesId.addAll(response.body!);
      }
    } finally {}

    try {
      var response = await _clinicApi.getExpensesId();

      if (response.statusCode == 200 && response.body != null) {
        expensesId.addAll(response.body!);
      }
    } finally {}

    try {
      var response = await _clinicApi.getFee();

      if (response.statusCode == 200 && response.body != null) {
        feeList.addAll(response.body!);
      }
    } finally {}
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

  void createMedicine() {
    database.databaseURL = dBUrl;
    final DatabaseReference reference = database.ref().child('Medicines');

    // Create a new reference for a new appointment

    for (var name in medicineList) {
      final newAppointRef = reference.push();
      newAppointRef.set({
        'name': name['name'],
      });
    }
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
