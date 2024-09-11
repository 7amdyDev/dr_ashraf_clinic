import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/controller/expense_controller.dart';
import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/db/asset_api.dart';
import 'package:dr_ashraf_clinic/db/revenue_api.dart';
import 'package:dr_ashraf_clinic/model/appointment_model.dart';
import 'package:dr_ashraf_clinic/model/finance_models.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:get/get.dart';

class FinanceController extends GetxController {
  RxList<RevenueAccounts> revenueAccountlst = <RevenueAccounts>[].obs;
  RxList<AppointmentFinance> totalAppointmentAccountslst =
      <AppointmentFinance>[].obs;
  RxList<AppointmentFinance> appointmentFinanceByDatelst =
      <AppointmentFinance>[].obs;
  RxList<AssetAccountsModel> assetAccountslst = <AssetAccountsModel>[].obs;
  RxList<AssetAccountsModel> assetDailyIncomelst = <AssetAccountsModel>[].obs;
  RxList<AssetAccountsModel> patientAssetAccountslst =
      <AssetAccountsModel>[].obs;
  RxList<AssetAccountsModel> appointmentCashReciept =
      <AssetAccountsModel>[].obs;
  RxInt appointUnPaid = 0.obs;
  RxInt patientBalance = 0.obs;
  RxInt patientTotalPaid = 0.obs;
  RxInt patientTotalUnPaid = 0.obs;
  RxInt accountRecordId = 0.obs;
  RxInt dailyIncome = 0.obs;
  var assetApi = Get.find<AssetApi>();
  var revenueApi = Get.find<RevenueApi>();
  RxInt cash = 0.obs;
  RxInt patientId = 0.obs;
  RxBool finaceLoading = false.obs;
  var expenseController = Get.find<ExpenseController>();
  var patientController = Get.find<PatientController>();
  final _clinicController = Get.find<ClinicController>();

// ------------ Account Assets ----------- //

  void onPatientAccountListUpdated() async {
    assetDailyIncomelst.clear();
    totalAppointmentAccountslst.clear();
    if (patientId.value != 0) {
      await getPatientAppointTotalAccount(patientId.value);
      await getPatientAssetList(patientId.value);
      getPatientCardFinance();
    }

    getFinanceList();
  }

  @override
  void onInit() {
    getFinanceList();
    getCash();
    patientChanged();
    super.onInit();
  }

  Future<void> getFinanceList() async {
    await getTotalDailyIncome();
    await getDailyIncomeList();
  }

  Future<void> getDailyIncomeList() async {
    finaceLoading.value = true;
    try {
      var response =
          await assetApi.getDailyIncomeList(_clinicController.clinicId.value);
      if (response.statusCode == 200) {
        assetDailyIncomelst.value = response.body!;
      }
    } finally {
      finaceLoading.value = false;
    }
    cash.value =
        (dailyIncome.value - expenseController.totalDailyExpenses.value);
  }

// reception page schedueled table
  Future<void> getAppointsFinanceByDate({DateTime? date}) async {
    appointmentFinanceByDatelst.clear();
    if (date == null) {
      finaceLoading.value = true;
      try {
        var response = await assetApi.getAppointmentFinanceByDate(
            _clinicController.clinicId.value,
            HFormatter.formatDate(DateTime.now(), reversed: true));
        if (response.statusCode == 200 && response.body != null) {
          appointmentFinanceByDatelst.addAll(response.body!);
        }
      } finally {
        finaceLoading.value = false;
      }
    } else {
      finaceLoading.value = true;
      try {
        var response = await assetApi.getAppointmentFinanceByDate(
            _clinicController.clinicId.value,
            HFormatter.formatDate(date, reversed: true));

        if (response.statusCode == 200 && response.body != null) {
          appointmentFinanceByDatelst.addAll(response.body!);
        }
      } finally {
        finaceLoading.value = false;
      }
    }
  }

  void patientChanged() {
    ever(patientController.patientId, (value) {
      patientId.value = value;
    });
  }

  void getCash() {
    ever(expenseController.totalDailyExpenses, (value) {
      // Call a function when observableValue changes
      cash.value = (dailyIncome.value - value);
    });
  }

  Future<void> getPatientAppointTotalAccount(int id) async {
    totalAppointmentAccountslst.clear();
    finaceLoading.value = true;
    try {
      var response = await assetApi.getPatientAppointmentFinance(id);
      if (response.statusCode == 200 && response.body != null) {
        totalAppointmentAccountslst.value = response.body!;
      }
    } finally {
      finaceLoading.value = false;
    }
  }

  Future<void> getPatientAssetList(int id) async {
    assetAccountslst.clear();
    finaceLoading.value = true;
    try {
      var response = await assetApi.getByPatientId(id);
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

  Future<void> addPatientCashReceipt(
      AppointmentModel appointData, int amount) async {
    try {
      var response = await assetApi.create(AssetAccountsModel(
          accountId: 301,
          appointmentId: appointData.id!,
          patientId: appointData.patientId,
          date: HFormatter.formatDate(DateTime.now(), reversed: true),
          serviceId: appointData.serviceId,
          clinicId: _clinicController.clinicId.value,
          fee: 0,
          debit: amount));
      if (response.statusCode == 201 && response.body != null) {}
    } finally {}
    for (var item in assetAccountslst) {
      if (item.accountId == 302 && item.appointmentId == appointData.id!) {
        finaceLoading.value = true;

        try {
          var response = await assetApi.update(
            item.copyWith(
                patientId: item.patientId,
                debit: item.debit - amount,
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
        getCashRecieptOnAppointment(appointData.id!, appointData.serviceId);
        getAppointmentBalance(appointData.id!, appointData.serviceId);
      },
    );
    onPatientAccountListUpdated();
  }

  Future<void> removePatientCashReceipt(
      int recordId, AppointmentModel appointData) async {
    var assetRecord =
        assetAccountslst.firstWhere((asset) => asset.id == recordId);

    for (var item in assetAccountslst) {
      if (item.accountId == 302 && item.appointmentId == appointData.id) {
        finaceLoading.value = true;

        try {
          var response = await assetApi.update(
            item.copyWith(
                patientId: item.patientId,
                debit: item.debit + assetRecord.debit,
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
      var response = await assetApi.update(assetRecord.copyWith(
          debit: 0,
          date: HFormatter.formatDate(DateTime.now(), reversed: true),
          id: recordId));

      if (response.statusCode == 201 && response.body != null) {}
    } finally {
      finaceLoading.value = false;
      cash.value =
          (dailyIncome.value - expenseController.totalDailyExpenses.value);
    }
    accountRecordId.value = 0;
    onPatientAccountListUpdated();
    getPatientAssetList(patientId.value).then(
      (value) {
        getCashRecieptOnAppointment(appointData.id!, appointData.serviceId);
        getAppointmentBalance(appointData.id!, appointData.serviceId);
      },
    );
  }

  Future<void> getTotalDailyIncome() async {
    finaceLoading.value = true;
    try {
      var response =
          await assetApi.getTotalDailyIncome(_clinicController.clinicId.value);

      if (response.statusCode == 200 && response.body != null) {
        dailyIncome.value = response.body!.total!;
      }
    } finally {
      finaceLoading.value = false;
    }
    cash.value =
        (dailyIncome.value - expenseController.totalDailyExpenses.value);
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
    assetApi.create(assetAccount);
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
    assetApi.create(assetAccount);
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

  // int getAppointmentAccount(int appointmentId) {
  //   return totalAppointmentAccountslst
  //       .firstWhere((appointment) => appointment.appointId == appointmentId)
  //       .unPaid;
  // }
}
