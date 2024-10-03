import 'package:dr_ashraf_clinic/db/clinic_api.dart';
import 'package:dr_ashraf_clinic/model/clinic_models.dart';
import 'package:dr_ashraf_clinic/model/consultation_model.dart';
import 'package:dr_ashraf_clinic/model/online_reserv_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/api_constants.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
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

  void addMedicineToDB(String name) {
    if (name.isEmpty) {
      return;
    }
    _addMedicineRecordToDB(
      'Medicines',
      {'name': name},
    ).then((onValue) {
      dbMedicineSearch.clear();
      dbMedicineSearch.add(MedicineModel.fromJson(onValue));
    });
  }

  Future<Map<String, dynamic>> _addMedicineRecordToDB(
      String path, Map<String, dynamic> data) async {
    try {
      // Push a new record to the specified path
      DatabaseReference ref = database.ref(path).push();
      await ref.set(data);
      HelperFunctions.showSnackBar('Record Added Successfully');
      // Return the added item along with its unique key
      return {
        'key': ref.key,
        ...data,
      };
    } catch (e) {
      // Handle any errors
      debugPrint("Error adding record: $e");
      return {};
    }
  }

  // Future<Map<String, dynamic>?> getMedicineRecordByKey(
  //     String path, String key) async {
  //   try {
  //     // Reference the specific record using the path and key
  //     DatabaseReference ref = database.ref('$path/$key');
  //     DataSnapshot snapshot = await ref.get();

  //     if (snapshot.exists) {
  //       // Return the data as a map
  //       return snapshot.value as Map<String, dynamic>;
  //     } else {
  //       debugPrint("No data available for the specified key.");
  //       return null; // Key does not exist
  //     }
  //   } catch (e) {
  //     debugPrint("Error retrieving record: $e");
  //     return null; // Handle the error
  //   }
  // }

  void searchMedicineDatabase(String query) async {
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
            key: key,
          ));
        }
      });
    }
  }

  void deleteMedcineFromDB(String key) {
    database.databaseURL = dBUrl;

    final DatabaseReference reference = database.ref().child('Medicines/$key');
    reference.remove().then((_) {
      HelperFunctions.showSnackBar('Record Deleted Successfully');
    }).catchError((error) {
      //  debugPrint('Error removing user: $error');
    });
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
