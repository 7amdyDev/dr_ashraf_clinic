import 'dart:async';

import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/controller/expense_controller.dart';
import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/db/asset_api.dart';
import 'package:dr_ashraf_clinic/model/appointment_model.dart';
import 'package:dr_ashraf_clinic/model/finance_models.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:get/get.dart';

class FinanceController extends GetxController {
  RxList<AppointmentFinance> totalAppointmentAccountslst =
      <AppointmentFinance>[].obs;
  RxList<AppointmentFinance> filteredAppointmentAccountslst =
      <AppointmentFinance>[].obs;
  RxList<AppointmentFinance> appointmentFinanceByDatelst =
      <AppointmentFinance>[].obs;
  RxList<AssetAccountsModel> assetAccountslst = <AssetAccountsModel>[].obs;
  RxList<AssetAccountsModel> assetDailyIncomelst = <AssetAccountsModel>[].obs;
  RxList<AssetAccountsModel> appointmentCashReciept =
      <AssetAccountsModel>[].obs;
  RxInt appointUnPaid = 0.obs;
  RxInt patientBalance = 0.obs;
  RxInt patientTotalPaid = 0.obs;
  RxInt patientTotalUnPaid = 0.obs;
  RxInt accountRecordId = 0.obs;
  RxInt dailyIncome = 0.obs;
  RxInt cash = 0.obs;
  RxBool finaceLoading = false.obs;
  final _expenseController = Get.find<ExpenseController>();
  final _patientController = Get.find<PatientController>();
  final _clinicController = Get.find<ClinicController>();
  final _assetApi = Get.find<AssetApi>();

// ------------ Account Assets ----------- //

  void onPatientAccountListUpdated({int? appointId}) async {
    assetDailyIncomelst.clear();
    totalAppointmentAccountslst.clear();
    filteredAppointmentAccountslst.clear();
    if (_patientController.patientId.value != 0) {
      await getPatientAppointTotalAccount(_patientController.patientId.value,
          appointId: appointId);
      await getPatientAssetList(_patientController.patientId.value);
      getPatientCardFinance();
    }

    getFinanceList();
  }

  @override
  void onInit() {
    startPeriodicUpdate();
    getCash();
    patientChanged();
    super.onInit();
  }

  Future<void> getFinanceList() async {
    await getTotalDailyIncome();
    await getDailyIncomeList();
  }

  void startPeriodicUpdate() {
    // Set the duration for the periodic execution
    const duration = Duration(seconds: 2);

    // Create a Timer that runs the function periodically
    Timer.periodic(duration, (Timer timer) {
      // You can add your periodic task logic here.
      getFinanceList();
      // Uncomment the following line to stop the timer after a certain condition is met
      // if (someCondition) {
      //   timer.cancel();
      // }
    });
  }

  Future<void> getDailyIncomeList() async {
    if (finaceLoading.value) {
      return;
    }
    finaceLoading.value = true;
    try {
      var response =
          await _assetApi.getDailyIncomeList(_clinicController.clinicId.value);
      if (response.statusCode == 200) {
        assetDailyIncomelst.value = response.body!;
      }
    } finally {
      finaceLoading.value = false;
    }
    cash.value =
        (dailyIncome.value - _expenseController.totalDailyExpenses.value);
  }

// reception page schedueled table
  Future<void> getAppointsFinanceByDate({DateTime? date}) async {
    if (date == null) {
      finaceLoading.value = true;
      try {
        var response = await _assetApi.getAppointmentFinanceByDate(
            _clinicController.clinicId.value,
            HFormatter.formatDate(DateTime.now(), reversed: true));
        if (response.statusCode == 200 && response.body != null) {
          appointmentFinanceByDatelst.clear();
          appointmentFinanceByDatelst.addAll(response.body!);
        }
      } finally {
        finaceLoading.value = false;
      }
    } else {
      finaceLoading.value = true;

      try {
        var response = await _assetApi.getAppointmentFinanceByDate(
            _clinicController.clinicId.value,
            HFormatter.formatDate(date, reversed: true));

        if (response.statusCode == 200 && response.body != null) {
          appointmentFinanceByDatelst.clear();
          appointmentFinanceByDatelst.addAll(response.body!);
        }
      } finally {
        finaceLoading.value = false;
      }
    }
  }

  void patientChanged() {
    ever(_patientController.patientId, (value) {
      onPatientAccountListUpdated();
    });
  }

  void getCash() {
    ever(_expenseController.totalDailyExpenses, (value) {
      // Call a function when observableValue changes
      cash.value = (dailyIncome.value - value);
    });
  }

  Future<void> getPatientAppointTotalAccount(int id, {int? appointId}) async {
    totalAppointmentAccountslst.clear();
    finaceLoading.value = true;
    try {
      var response = await _assetApi.getPatientAppointmentFinance(id);
      if (response.statusCode == 200 && response.body != null) {
        totalAppointmentAccountslst.value = response.body!;
        if (appointId != null) {
          filteredAppointmentAccountslst.value = totalAppointmentAccountslst
              .where((total) => total.appointmentId == appointId)
              .toList();
        }
      }
    } finally {
      finaceLoading.value = false;
    }
  }

  Future<void> getPatientAssetList(int id) async {
    assetAccountslst.clear();
    finaceLoading.value = true;
    try {
      var response = await _assetApi.getByPatientId(id);
      if (response.statusCode == 200 && response.body != null) {
        assetAccountslst.value = response.body!;
      }
    } finally {
      finaceLoading.value = false;
    }
  }

  void getAppointmentBalance(int appointId, int serviceId) {
    appointUnPaid.value = assetAccountslst
        .firstWhere((appointment) =>
            appointment.appointmentId == appointId &&
            appointment.serviceId == serviceId &&
            appointment.accountId == 302)
        .debit;
  }

  void getPatientCardFinance() {
    int amount = 0;
    int paid = 0;
    int unPaid = 0;
    for (var item in assetAccountslst) {
      if (item.accountId == 301) {
        amount += (item.fee - item.discount);
        paid += item.debit;
      } else if (item.accountId == 302) {
        amount += (item.fee - item.discount);
        unPaid += item.debit;
      }
    }
    patientBalance.value = amount;
    patientTotalPaid.value = paid;
    patientTotalUnPaid.value = unPaid;
  }

  Future<void> updatePatientCashReceipt(
      int appointId, int serviceId, int discount) async {
    for (var item in assetAccountslst) {
      if (item.accountId == 302 &&
          item.appointmentId == appointId &&
          item.serviceId == serviceId) {
        finaceLoading.value = true;

        try {
          var response = await _assetApi.update(
            item.copyWith(
                patientId: item.patientId,
                debit: discount == 0
                    ? item.discount + item.debit
                    : item.debit - discount,
                serviceId: serviceId,
                date: HFormatter.formatDate(DateTime.now(), reversed: true),
                id: item.id,
                discount: discount == 0 ? discount : item.discount + discount),
          );
          if (response.statusCode == 201 && response.body != null) {
            HelperFunctions.showSnackBar('Record Updated Succesfully');
          }
        } finally {
          finaceLoading.value = false;
        }
      }
    }
    getPatientAssetList(_patientController.patientId.value).then(
      (_) {
        getCashRecieptOnAppointment(appointId, serviceId);
        getAppointmentBalance(appointId, serviceId);
      },
    );
    onPatientAccountListUpdated(appointId: appointId);
  }

  Future<void> addPatientCashReceipt(
      AppointmentModel appointData, int serviceId, int amount) async {
    try {
      var response = await _assetApi.create(AssetAccountsModel(
          accountId: 301,
          appointmentId: appointData.id!,
          patientId: appointData.patientId,
          date: HFormatter.formatDate(DateTime.now(), reversed: true),
          serviceId: serviceId,
          clinicId: _clinicController.clinicId.value,
          fee: 0,
          debit: amount));
      if (response.statusCode == 201 && response.body != null) {}
    } finally {}
    for (var item in assetAccountslst) {
      if (item.accountId == 302 &&
          item.appointmentId == appointData.id! &&
          item.serviceId == serviceId) {
        finaceLoading.value = true;

        try {
          var response = await _assetApi.update(
            item.copyWith(
                patientId: item.patientId,
                debit: item.debit - amount,
                serviceId: serviceId,
                date: HFormatter.formatDate(DateTime.now(), reversed: true),
                id: item.id),
          );
          if (response.statusCode == 201 && response.body != null) {
            HelperFunctions.showSnackBar('Record Updated Succesfully');
          }
        } finally {
          finaceLoading.value = false;
        }
      }
    }
    getPatientAssetList(appointData.patientId).then(
      (value) {
        getCashRecieptOnAppointment(appointData.id!, serviceId);
        getAppointmentBalance(appointData.id!, serviceId);
      },
    );
    onPatientAccountListUpdated();
  }

  Future<void> removePatientEndoscopyService(
      int appointId, int serviceId) async {
    for (var item in assetAccountslst) {
      if (item.appointmentId == appointId && item.serviceId == serviceId) {
        finaceLoading.value = true;

        try {
          var response = await _assetApi.remove(item.id!);
          if (response.statusCode == 201 && response.body != null) {
            HelperFunctions.showSnackBar('Record Updated Succesfully');
          }
        } finally {
          finaceLoading.value = false;
        }
      }
    }
    getCashRecieptOnAppointment(appointId, serviceId);
    getAppointmentBalance(appointId, serviceId);
    onPatientAccountListUpdated(appointId: appointId);
  }

  Future<void> removePatientCashReceipt(
      int recordId, AppointmentModel appointData, int serviceId) async {
    var assetRecord =
        assetAccountslst.firstWhere((asset) => asset.id == recordId);

    for (var item in assetAccountslst) {
      if (item.accountId == 302 &&
          item.appointmentId == appointData.id &&
          item.serviceId == serviceId) {
        finaceLoading.value = true;

        try {
          var response = await _assetApi.update(
            item.copyWith(
                patientId: item.patientId,
                debit: item.debit + assetRecord.debit,
                serviceId: serviceId,
                date: HFormatter.formatDate(DateTime.now(), reversed: true),
                id: item.id),
          );
          if (response.statusCode == 201 && response.body != null) {
            HelperFunctions.showSnackBar('Record Updated Succesfully');
          }
        } finally {
          finaceLoading.value = false;
        }
      }
    }

    try {
      var response = await _assetApi.update(assetRecord.copyWith(
          debit: 0,
          serviceId: serviceId,
          date: HFormatter.formatDate(DateTime.now(), reversed: true),
          id: recordId));

      if (response.statusCode == 201 && response.body != null) {}
    } finally {
      finaceLoading.value = false;
      cash.value =
          (dailyIncome.value - _expenseController.totalDailyExpenses.value);
    }
    accountRecordId.value = 0;
    onPatientAccountListUpdated();
    getPatientAssetList(_patientController.patientId.value).then(
      (value) {
        getCashRecieptOnAppointment(appointData.id!, serviceId);
        getAppointmentBalance(appointData.id!, serviceId);
      },
    );
  }

  Future<void> getTotalDailyIncome() async {
    if (finaceLoading.value) {
      return;
    }
    finaceLoading.value = true;
    try {
      var response =
          await _assetApi.getTotalDailyIncome(_clinicController.clinicId.value);

      if (response.statusCode == 200 && response.body != null) {
        dailyIncome.value = response.body!.total!;
      }
    } finally {
      finaceLoading.value = false;
    }
    cash.value =
        (dailyIncome.value - _expenseController.totalDailyExpenses.value);
  }

  void addAssetCashOnHand({
    required int appointmentId,
    required int patientId,
    required String date,
    required int serviceId,
    required int fee,
    required int debit,
  }) {
    var assetAccount = AssetAccountsModel(
      accountId: 301,
      appointmentId: appointmentId,
      patientId: patientId,
      date: date,
      serviceId: serviceId,
      clinicId: _clinicController.clinicId.value,
      fee: fee,
      debit: debit,
    );
    _assetApi.create(assetAccount);
  }

  void addAccountRecievable({
    required int appointmentId,
    required int patientId,
    required String date,
    required int serviceId,
    required int fee,
    required int debit,
  }) {
    var assetAccount = AssetAccountsModel(
      accountId: 302,
      appointmentId: appointmentId,
      patientId: patientId,
      date: date,
      serviceId: serviceId,
      clinicId: _clinicController.clinicId.value,
      fee: fee,
      debit: debit,
    );
    _assetApi.create(assetAccount);
  }

  void getCashRecieptOnAppointment(int appointmentId, int serviceId) {
    appointmentCashReciept.clear();
    for (var item in assetAccountslst) {
      if (item.accountId == 301 &&
          item.appointmentId == appointmentId &&
          item.serviceId == serviceId &&
          item.debit != 0) {
        appointmentCashReciept.add(item);
      }
    }
  }
}
