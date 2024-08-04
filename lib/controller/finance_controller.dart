import 'package:dr_ashraf_clinic/model/appointment_model.dart';
import 'package:dr_ashraf_clinic/model/expense_model.dart';
import 'package:dr_ashraf_clinic/model/finance_models.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class FinanceController extends GetxController {
  RxList<RevenueAccounts> revenueAccountlst = <RevenueAccounts>[].obs;
  RxList<AppointmentFinance> appointmentAccountslst =
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
  RxInt totalDailyExpenses = 0.obs;
  RxInt cash = 0.obs;
  RxList<ExpenseModel> expenseSearchResult = <ExpenseModel>[].obs;
  RxInt patientId = 0.obs;
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

  void onPatientAccountListUpdated() {
    getPatientAccountslst();
  }

  void _addRevenueToAccount(int appointmentId, int patientId, String dateTime,
      int serviceId, int amount) {
    var revenueAccount = RevenueAccounts(
        revenueAccount: 101,
        appointmentId: appointmentId,
        patientId: patientId,
        dateTime: dateTime,
        amount: amount,
        serviceId: serviceId);
    revenueAccountlst.add(revenueAccount);
  }

  void getPatientAccountslst() {
    patientAssetAccountslst.clear();
    patientAppointslst.clear();
    int amount = 0;
    int paid = 0;
    int unPaid = 0;
    for (var item in assetAccountslst) {
      if (item.accountNumber == 301 && item.patientId == patientId.value) {
        amount += item.fee;
        paid += item.debit;
        patientAppointslst.add(item.appointmentId);
        patientAssetAccountslst.add(item);
      } else if (item.accountNumber == 302 &&
          item.patientId == patientId.value) {
        amount += item.fee;
        unPaid += item.debit;
        patientAppointslst.add(item.appointmentId);
        patientAssetAccountslst.add(item);
      }
      patientBalance.value = amount;
      patientTotalPaid.value = paid;
      patientTotalUnPaid.value = unPaid;
      patientAppointslst.value = patientAppointslst.toSet().toList();
    }
    getPatientAppointAccount();
  }

  void getAppointmentBalance(int appointId) {
    appointUnPaid.value = appointmentAccountslst
        .firstWhere((appointment) => appointment.appointId == appointId)
        .unPaid;
  }

  void getPatientAppointAccount() {
    appointmentAccountslst.clear();
    for (var appointId in patientAppointslst) {
      int amount = 0;
      int paid = 0;
      int unPaid = 0;
      int patientId = 0;
      for (var item in patientAssetAccountslst) {
        if (item.accountNumber == 301 && item.appointmentId == appointId) {
          patientId = item.patientId;
          amount += item.fee;
          paid += item.debit;
        } else if (item.accountNumber == 302 &&
            item.appointmentId == appointId) {
          patientId = item.patientId;
          amount += item.fee;
          unPaid += item.debit;
        }
      }

      appointmentAccountslst.add(AppointmentFinance(
          appointId: appointId,
          patientId: patientId,
          serviceFee: amount,
          paid: paid,
          unPaid: unPaid));
    }
  }

  void addPatientCashReceipt(AppointmentModel appointData, int amount) {
    for (var item in patientAssetAccountslst) {
      if (item.accountNumber == 302 && item.appointmentId == appointData.id!) {
        item.debit -= amount;
      }
    }
    addAssetCashOnHand(
        appointmentId: appointData.id!,
        patientId: appointData.patientId,
        dateTime: HFormatter.formatDate(DateTime.now()),
        serviceId: appointData.serviceId,
        fee: 0,
        debit: amount);
    onPatientAccountListUpdated();
    getAppointmentBalance(appointData.id!);
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
      if (item.accountNumber == 302 &&
          item.appointmentId == assetAccountslst[recordIndex].appointmentId) {
        item.debit += amount;
        appointId = item.appointmentId;
      }
    }
    accountRecordId.value = 0;
    onPatientAccountListUpdated();
    if (appointId != 0) getAppointmentBalance(appointId);
  }

  void getDailyCash() {
    int balance = 0;
    assetDailyIncomelst.clear();
    for (var item in assetAccountslst) {
      if (item.accountNumber == 301 &&
          item.debit != 0 &&
          item.dateTime == HFormatter.formatDate(DateTime.now())) {
        balance += item.debit;
        assetDailyIncomelst.add(item);
      }
    }
    dailyIncome.value = balance;
    cash.value = dailyIncome.value - totalDailyExpenses.value;
  }

  void addAssetCashOnHand({
    required int appointmentId,
    required int patientId,
    required String dateTime,
    required int serviceId,
    required int fee,
    required int debit,
  }) {
    var assetAccount = AssetAccountsModel(
      id: assetAccountslst.length + 1,
      accountNumber: 301,
      appointmentId: appointmentId,
      patientId: patientId,
      dateTime: dateTime,
      serviceId: serviceId,
      fee: fee,
      debit: debit,
    );

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
    required int fee,
    required int debit,
  }) {
    var assetAccount = AssetAccountsModel(
      id: assetAccountslst.length + 1,
      accountNumber: 302,
      appointmentId: appointmentId,
      patientId: patientId,
      dateTime: dateTime,
      serviceId: serviceId,
      fee: fee,
      debit: debit,
    );

    assetAccountslst.add(assetAccount);
  }

  void getCashRecieptOnAppointment(int appointmentId) {
    appointmentCashReciept.clear();
    for (var item in patientAssetAccountslst) {
      if (item.accountNumber == 301 &&
          item.appointmentId == appointmentId &&
          item.debit != 0) {
        appointmentCashReciept.add(item);
      }
    }
  }

  int getAppointmentAccount(int appointmentId) {
    return appointmentAccountslst
        .firstWhere((appointment) => appointment.appointId == appointmentId)
        .unPaid;
  }
}
