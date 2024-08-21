import 'package:dr_ashraf_clinic/db/asset_api.dart';
import 'package:dr_ashraf_clinic/db/revenue_api.dart';
import 'package:dr_ashraf_clinic/model/appointment_model.dart';
import 'package:dr_ashraf_clinic/model/finance_models.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:get/get.dart';

class FinanceController extends GetxController {
  RxList<RevenueAccounts> revenueAccountlst = <RevenueAccounts>[].obs;
  RxList<AppointmentFinance> totalAppointmentAccountslst =
      <AppointmentFinance>[].obs;
  RxList<AssetAccountsModel> assetAccountslst = <AssetAccountsModel>[].obs;
  RxList<AssetAccountsModel> assetDailyIncomelst = <AssetAccountsModel>[].obs;
  RxList<AssetAccountsModel> patientAssetAccountslst =
      <AssetAccountsModel>[].obs;
  RxList<AssetAccountsModel> appointmentCashReciept =
      <AssetAccountsModel>[].obs;
  RxList<int> patientAppointslst = <int>[].obs;
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

// ------------ Account Assets ----------- //

  void onPatientAccountListUpdated() async {
    await getPatientAppointTotalAccount(patientId.value);
    await getPatientAssetList(patientId.value);
    getPatientCardFinance();
  }

  @override
  void onInit() {
    getFinanceList();
    super.onInit();
  }

  Future<void> getFinanceList() async {
    await getTotalDailyIncome();
    await getDailyIncomeList();
  }

  Future<void> getDailyIncomeList() async {
    finaceLoading.value = true;
    try {
      var response = await assetApi.getDailyIncomeList();
      if (response.statusCode == 200) {
        assetDailyIncomelst.value = response.body!;
      }
    } finally {
      finaceLoading.value = false;
    }
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

  // void getAppointmentBalance(int appointId) {
  //   appointUnPaid.value = totalAppointmentAccountslst
  //       .firstWhere((appointment) => appointment.appointmentId == appointId)
  //       .unPaid;
  // }

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

  void addPatientCashReceipt(AppointmentModel appointData, int amount) {
    for (var item in patientAssetAccountslst) {
      if (item.accountId == 302 && item.appointmentId == appointData.id!) {
        item.debit -= amount;
      }
    }
    addAssetCashOnHand(
        appointmentId: appointData.id!,
        patientId: appointData.patientId,
        date: HFormatter.formatDate(DateTime.now()),
        serviceId: appointData.serviceId,
        fee: 0,
        debit: amount);
    onPatientAccountListUpdated();
    // getAppointmentBalance(appointData.id!);
  }

  void removePatientCashReceipt(int recordId) {
    int amount = 0;
    int appointId = 0;
    int recordIndex =
        assetAccountslst.indexWhere((record) => record.id == recordId);
    if (recordIndex != -1) {
      amount = assetAccountslst[recordIndex].debit;
      assetAccountslst[recordIndex].debit = 0;
    }
    for (var item in patientAssetAccountslst) {
      if (item.accountId == 302 &&
          item.appointmentId == assetAccountslst[recordIndex].appointmentId) {
        item.debit += amount;
        appointId = item.appointmentId;
      }
    }
    accountRecordId.value = 0;
    onPatientAccountListUpdated();
    // if (appointId != 0) getAppointmentBalance(appointId);
  }

  Future<void> getTotalDailyIncome() async {
    finaceLoading.value = true;
    try {
      var response = await assetApi.getTotalDailyIncome();

      if (response.statusCode == 200 && response.body != null) {
        dailyIncome.value = response.body!.total!;
      }
    } finally {
      finaceLoading.value = false;
      //  cash.value = dailyIncome.value - totalDailyExpenses.value;
    }
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
      fee: fee,
      debit: debit,
    );
    assetApi.create(assetAccount);
  }

  void getCashRecieptOnAppointment(int appointmentId) {
    appointmentCashReciept.clear();
    for (var item in assetAccountslst) {
      if (item.accountId == 301 &&
          item.appointmentId == appointmentId &&
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
