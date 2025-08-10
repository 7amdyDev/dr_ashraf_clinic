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
  RxList<OnlineReservModel> filteredOnlineReservData =
      <OnlineReservModel>[].obs;

  RxList<ReferralModel> dbReferralsList = <ReferralModel>[].obs;
  RxInt pageIndex = 0.obs;
  RxList<ServicesId> servicesId = <ServicesId>[].obs;
  RxList<AccountsId> expensesId = <AccountsId>[].obs;
  RxList<Fee> feeList = <Fee>[].obs;
  RxList<Fee> filteredFeeList = <Fee>[].obs;
  RxList<ClinicId> clinicBranches = <ClinicId>[].obs;
  RxInt clinicId = 1.obs;
  RxList<MedicineModel> dbMedicineSearch = <MedicineModel>[].obs;
  RxList<ExaminationModel> dbExaminationSearch = <ExaminationModel>[].obs;
  Rx<DateTime> selectedDate = DateTime.now()
      .subtract(const Duration(hours: 2))
      .obs;
  RxBool scheduleByDate = false.obs;
  RxList<String> dosageSuggestion = <String>[].obs;
  final database = FirebaseDatabase.instance;

  @override
  void onInit() {
    super.onInit();
    getClinicData();
    dateChanged();
    feeChanged();
    clinicIdChanged();
    getOnlineReservationData();
  }

  void dateChanged() {
    ever(selectedDate, (value) {
      if (DateTime.now().subtract(const Duration(hours: 2)) != value) {
        scheduleByDate.value = true;
      } else {
        scheduleByDate.value = false;
      }
    });
  }

  void clinicIdChanged() {
    ever(clinicId, (value) {
      getOnlineReservationData();
    });
  }

  void getOnlineReservationData() {
    getDosageSuggestionList();
    database.databaseURL = dBUrl;
    final DatabaseReference reference = database.ref().child(
      'Reservations', // Changed to 'Reservations' for consistency
    );
    reference.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map?;
      onlineReservData.clear();

      if (data != null && data.isNotEmpty) {
        data.forEach((key, value) {
          if (value['clinicId'] == clinicId.value) {
            onlineReservData.add(
              OnlineReservModel(
                id: key,
                name: value["name"],
                mobile: value["mobile"],
                dateTime: value["date"],
                clinicId: value["clinicId"],
                isScheduled: value["isScheduled"] ?? false,
              ),
            );
          }
        });
      }
    });
  }

  void getReferralsList() {
    database.databaseURL = dBUrl;
    final DatabaseReference reference = database.ref().child('Referrals');
    reference.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        dbReferralsList.clear();
        data.forEach((key, value) {
          dbReferralsList.add(ReferralModel(name: value["name"], key: key));
        });
      }
    });
  }

  void addMedicineToDB(String name) {
    if (name.isEmpty) {
      return;
    }
    _addMedicineRecordToDB('Medicines', {'name': name}).then((onValue) {
      dbMedicineSearch.clear();
      dbMedicineSearch.add(MedicineModel.fromJson(onValue));
    });
  }

  Future<Map<String, dynamic>> _addMedicineRecordToDB(
    String path,
    Map<String, dynamic> data,
  ) async {
    try {
      // Push a new record to the specified path
      DatabaseReference ref = database.ref(path).push();
      await ref.set(data);
      HelperFunctions.showSnackBar('Record Added Successfully');
      // Return the added item along with its unique key
      return {'key': ref.key, ...data};
    } catch (e) {
      // Handle any errors
      debugPrint("Error adding record: $e");
      return {};
    }
  }

  // add a new referral to the database
  void addReferralToDB(String name) {
    if (name.isEmpty) {
      return;
    }
    _addReferralNameToDB('Referrals', {'name': name}).then((onValue) {
      getReferralsList();
    });
  }

  Future<Map<String, dynamic>> _addReferralNameToDB(
    String path,
    Map<String, dynamic> data,
  ) async {
    try {
      // Push a new record to the specified path
      DatabaseReference ref = database.ref(path).push();
      await ref.set(data);
      HelperFunctions.showSnackBar('Record Added Successfully');
      // Return the added item along with its unique key
      return {'key': ref.key, ...data};
    } catch (e) {
      // Handle any errors
      debugPrint("Error adding record: $e");
      return {};
    }
  }

  // Add a new examination to the database
  void addExaminationToDB(String name) {
    if (name.isEmpty) {
      return;
    }
    _addExaminationNameToDB('Examinations', {'name': name}).then((onValue) {
      dbExaminationSearch.clear();
      dbExaminationSearch.add(ExaminationModel.fromJson(onValue));
    });
  }

  Future<Map<String, dynamic>> _addExaminationNameToDB(
    String path,
    Map<String, dynamic> data,
  ) async {
    try {
      // Push a new record to the specified path
      DatabaseReference ref = database.ref(path).push();
      await ref.set(data);
      HelperFunctions.showSnackBar('Record Added Successfully');
      // Return the added item along with its unique key
      return {'key': ref.key, ...data};
    } catch (e) {
      // Handle any errors
      debugPrint("Error adding record: $e");
      return {};
    }
  }

  Future<void> updateFeeList(Fee fee) async {
    try {
      var response = await _clinicApi.updateFee(fee);
      if (response.statusCode == 201 && response.body != null) {
        HelperFunctions.showSnackBar('Record Updated Successfully');
        getServiceFees();
      }
    } finally {}
  }

  void feeChanged() {
    ever(feeList, (value) {
      filteredFeeList.value = feeList
          .where((item) => item.serviceId != 3 && item.serviceId != 4)
          .toList();
    });
  }

  void searchMedicineDatabase(String query) async {
    if (query.isEmpty) {
      dbMedicineSearch.clear();
      return;
    }
    database.databaseURL = dBUrl;
    final DatabaseReference dbRef = database.ref().child('Medicines');

    final snapshot = await dbRef.once();
    final data = snapshot.snapshot.value as Map<dynamic, dynamic>?;

    if (data != null && query.length >= 2) {
      dbMedicineSearch.clear();
      data.forEach((key, value) {
        if (value['name'].toLowerCase().startsWith(query)) {
          dbMedicineSearch.add(MedicineModel(name: value["name"], key: key));
        }
      });
    }
  }

  void searchExaminationDatabase(String query) async {
    if (query.isEmpty) {
      dbExaminationSearch.clear();
      return;
    }
    database.databaseURL = dBUrl;
    final DatabaseReference dbRef = database.ref().child('Examinations');

    final snapshot = await dbRef.once();
    final data = snapshot.snapshot.value as Map<dynamic, dynamic>?;

    if (data != null && query.isNotEmpty) {
      dbExaminationSearch.clear();
      data.forEach((key, value) {
        if (value['name'].toLowerCase().startsWith(query)) {
          dbExaminationSearch.add(
            ExaminationModel(name: value["name"], key: key),
          );
        }
      });
    }
  }

  void getDosageSuggestionList() async {
    database.databaseURL = dBUrl;
    final DatabaseReference dbRef = database.ref().child('Dosage');
    final snapshot = await dbRef.once();
    final data = snapshot.snapshot.value as Map<dynamic, dynamic>?;
    if (data != null) {
      dosageSuggestion.clear();
      data.forEach((key, value) {
        dosageSuggestion.add(value);
      });
    }
  }

  void saveDosageToDB(String item) async {
    database.databaseURL = dBUrl;
    final DatabaseReference dbRef = database.ref().child('Dosage');
    if (!dosageSuggestion.contains(item)) {
      await dbRef.push().set(item).then((_) {
        dosageSuggestion.add(item);
      });
    }
  }

  void deleteMedcineFromDB(String key) {
    database.databaseURL = dBUrl;

    final DatabaseReference reference = database.ref().child('Medicines/$key');
    reference
        .remove()
        .then((_) {
          HelperFunctions.showSnackBar('Record Deleted Successfully');
        })
        .catchError((error) {
          //  debugPrint('Error removing user: $error');
        });
  }

  void deleteReferralFromDB(String key) {
    database.databaseURL = dBUrl;

    final DatabaseReference reference = database.ref().child('Referrals/$key');
    reference
        .remove()
        .then((_) {
          HelperFunctions.showSnackBar('Record Deleted Successfully');
          getReferralsList();
        })
        .catchError((error) {
          //  debugPrint('Error removing user: $error');
        });
  }

  void deleteExaminationFromDB(String key) {
    database.databaseURL = dBUrl;

    final DatabaseReference reference = database.ref().child(
      'Examinations/$key',
    );
    reference
        .remove()
        .then((_) {
          HelperFunctions.showSnackBar('Record Deleted Successfully');
        })
        .catchError((error) {
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
    getClinicBranches();

    getServicesList();

    getExpensesList();

    getServiceFees();

    getReferralsList();
  }

  Future<void> getClinicBranches() async {
    if (clinicBranches.isNotEmpty) {
      clinicBranches.clear();
    }
    try {
      var response = await _clinicApi.getClinicBranches();
      if (response.statusCode == 200 && response.body != null) {
        clinicBranches.addAll(response.body!);
      }
    } finally {}
  }

  Future<void> getServicesList() async {
    if (servicesId.isNotEmpty) {
      servicesId.clear();
    }

    try {
      var response = await _clinicApi.getServices();

      if (response.statusCode == 200 && response.body != null) {
        servicesId.addAll(response.body!);
      }
    } finally {}
  }

  Future<void> getExpensesList() async {
    if (expensesId.isNotEmpty) {
      expensesId.clear();
    }
    try {
      var response = await _clinicApi.getExpensesId();

      if (response.statusCode == 200 && response.body != null) {
        expensesId.addAll(response.body!);
      }
    } finally {}
  }

  Future<void> getServiceFees() async {
    if (feeList.isNotEmpty) {
      feeList.clear();
    }
    try {
      var response = await _clinicApi.getFee();

      if (response.statusCode == 200 && response.body != null) {
        feeList.addAll(response.body!);
      }
    } finally {}
  }

  void createOnlineReserv(OnlineReservModel model) {
    database.databaseURL = dBUrl;
    final DatabaseReference reference = database.ref().child('Reservations');

    final newAppointRef = reference
        .push(); // Create a new reference for a new appointment
    newAppointRef
        .set({
          'name': model.name,
          'date': model.dateTime,
          'mobile': model.mobile,
          'clinicId': model.clinicId,
          'isScheduled': model.isScheduled,
        })
        .then((_) {
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
        })
        .catchError((error) {
          //debugPrint('Error adding user: $error');
        });
  }

  void deleteOnlineReserv(String appointId) {
    database.databaseURL = dBUrl;

    final DatabaseReference reference = database.ref().child(
      'Reservations/$appointId',
    );
    reference
        .update({'isScheduled': true})
        .then((_) {
          // debugPrint('User removed successfully');
          // Get.snackbar('Title', 'Checked', snackPosition: SnackPosition.BOTTOM);
        })
        .catchError((error) {
          //  debugPrint('Error removing user: $error');
        });
  }
}
