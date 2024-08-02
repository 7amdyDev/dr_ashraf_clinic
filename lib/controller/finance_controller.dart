import 'package:dr_ashraf_clinic/model/expense_model.dart';
import 'package:dr_ashraf_clinic/model/finance_models.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class FinanceController extends GetxController {
  RxList<RevenueAccounts> revenueAccountlst = <RevenueAccounts>[].obs;
  RxList<AppointmentFinance> appointmentFinancelst = <AppointmentFinance>[].obs;
  RxList<AssetAccountsModel> assetAccountslst = <AssetAccountsModel>[].obs;
  RxList<AssetAccountsModel> assetDailyIncomelst = <AssetAccountsModel>[].obs;
  RxList<AssetAccountsModel> patientAssetAccountlst =
      <AssetAccountsModel>[].obs;
  RxList<AssetAccountsModel> appointmentCashReciept =
      <AssetAccountsModel>[].obs;

  RxInt patientTotalAccount = 0.obs;
  RxInt patientPaidAccount = 0.obs;
  RxInt patientUnPaidAccount = 0.obs;
  RxInt accountRecordId = 0.obs;
  RxInt dailyIncome = 0.obs;
  RxInt totalDailyExpenses = 0.obs;
  RxInt cash = 0.obs;
  RxList<ExpenseModel> expenseSearchResult = <ExpenseModel>[].obs;

// -------- Expenses Functions --------------- //
  void addExpense(ExpenseModel expense) {
    expenseSearchResult.add(expense); // Update the list
    // Call your function here
    onExpenseListUpdated(); // Example function call
  }

  void deleteExpense(int id) {
    expenseSearchResult
        .removeWhere((element) => element.id == id); // Update the list
    // Call your function here
    onExpenseListUpdated(); // Example function call
  }

  void onExpenseListUpdated() {
    int totalExpense = 0;
    for (var item in expenseSearchResult) {
      totalExpense += item.value;
    }
    totalDailyExpenses.value = totalExpense;
    cash.value = dailyIncome.value - totalDailyExpenses.value;
  }

// ------------ Account Assets ----------- //
  void _addRevenueToAccount(int appointmentId, int patientId, String dateTime,
      int serviceId, int value) {
    var revenueAccount = RevenueAccounts(
        revenueAccount: 101,
        appointmentId: appointmentId,
        patientId: patientId,
        dateTime: dateTime,
        value: value,
        serviceId: serviceId);
    revenueAccountlst.add(revenueAccount);
  }

  void getPatientAccountlst(int id) {
    patientAssetAccountlst.clear();
    // int value = 0;
    // int paid = 0;
    // int unpaid = 0;
    List<int> appointments = [];
    for (var item in assetAccountslst) {
      if ((item.accountNumber == 302 || item.accountNumber == 301) &&
          item.patientId == id) {
        patientAssetAccountlst.add(item);
        appointments.add(item.appointmentId);
      }
    }

    appointments = appointments.toSet().toList();
    appointmentFinancelst.clear();
    for (var item in appointments) {
      getPatientAccountsByAppointment(item);
    }
    // patientTotalAccount.value = value;
    // patientPaidAccount.value = paid;
    // patientUnPaidAccount.value = unpaid;
  }

  void getPatientAccountsByAppointment(int appointmentId) {
    int amount = 0;
    int paid = 0;
    int unPaid = 0;
    String? dateTime;
    int? patientId;
    int? serviceId;
    for (var item in patientAssetAccountlst) {
      print(item.serviceId);
      dateTime = item.dateTime;
      patientId = item.patientId;
      serviceId = item.serviceId;
      if (item.appointmentId == appointmentId && item.accountNumber == 301) {
        amount = item.value;
        paid += item.debit;
      } else if (item.appointmentId == appointmentId &&
          item.accountNumber == 302) {
        amount = item.value;
        unPaid += item.debit;
      }
    }

    appointmentFinancelst.add(AppointmentFinance(
        appointId: appointmentId,
        patientId: patientId!,
        dateTime: dateTime!,
        serviceId: serviceId!,
        amount: amount,
        paid: paid,
        unPaid: unPaid));
  }

  AssetAccountsModel getAssetAccountByRecordId(int id) {
    var record =
        patientAssetAccountlst.firstWhere((element) => element.id == id);

    return record;
  }

  void patientCashReceipt(AssetAccountsModel record) {
    // int indexToUpdate =
    //     patientAssetAccountlst.indexWhere((element) => element.id == record.id);

    // if (indexToUpdate != -1) {
    //   // Update the record at the found index
    //   // patientAssetAccountlst[indexToUpdate] = record;
    //   addAssetCashOnHand(record.appointmentId, record.patientId,
    //       record.dateTime, record.serviceId, 0, record.debit);
    //   addAccountRecievable(
    //       appointmentId: record.appointmentId,
    //       patientId: record.patientId,
    //       dateTime: record.dateTime,
    //       serviceId: record.serviceId,
    //       value: 0,
    //       debit: 0,
    //       credit: record.debit);
    // }
  }

  void getDailyCash() {
    int value = 0;
    assetDailyIncomelst.clear();
    for (var item in assetAccountslst) {
      if (item.accountNumber == 301 &&
          item.dateTime == HFormatter.formatDate(DateTime.now())) {
        value += item.debit;
        assetDailyIncomelst.add(item);
      }
    }
    dailyIncome.value = value;
    cash.value = dailyIncome.value - totalDailyExpenses.value;
  }

  void addAssetCashOnHand({
    required int appointmentId,
    required int patientId,
    required String dateTime,
    required int serviceId,
    required int value,
    required int debit,
  }) {
    var assetAccount = AssetAccountsModel(
        accountNumber: 301,
        appointmentId: appointmentId,
        patientId: patientId,
        dateTime: dateTime,
        serviceId: serviceId,
        value: value,
        debit: debit,
        credit: 0);

    assetAccountslst.add(assetAccount);
    getDailyCash();
    _addRevenueToAccount(
      appointmentId,
      patientId,
      dateTime,
      serviceId,
      debit,
    );
  }

  void addAccountRecievable({
    required int appointmentId,
    required int patientId,
    required String dateTime,
    required int serviceId,
    required int value,
    required int debit,
  }) {
    var assetAccount = AssetAccountsModel(
      id: assetAccountslst.length + 1,
      accountNumber: 302,
      appointmentId: appointmentId,
      patientId: patientId,
      dateTime: dateTime,
      serviceId: serviceId,
      value: value,
      debit: debit,
      credit: 0,
    );

    assetAccountslst.add(assetAccount);
  }

  void getCashRecieptOnAppointment(int appointmentId) {
    appointmentCashReciept.clear();
    for (var item in patientAssetAccountlst) {
      if (item.accountNumber == 301 && item.appointmentId == appointmentId) {
        appointmentCashReciept.add(item);
      }
    }
  }

  int getAppointmentAccount(int appointmentId) {
    var assetAccount = assetAccountslst.firstWhere((element) =>
        (element.appointmentId == appointmentId &&
            (element.accountNumber == 302 || element.accountNumber == 301)));

    return assetAccount.debit;
  }
}
