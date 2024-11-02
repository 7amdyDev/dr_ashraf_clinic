import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/db/reports_api.dart';
import 'package:dr_ashraf_clinic/model/expense_model.dart';
import 'package:dr_ashraf_clinic/model/reports_model.dart';
import 'package:get/get.dart';

class ReportsController extends GetxController {
  final _clinicController = Get.find<ClinicController>();
  final _reportsApi = Get.find<ReportsApi>();
  RxList<IncomeExpenseModel> incomeExpenseOverview = <IncomeExpenseModel>[].obs;
  RxList<IncomeReferralModel> incomeReferralByDate =
      <IncomeReferralModel>[].obs;
  RxList<ExpenseOverviewModel> expenseOverviewByDate =
      <ExpenseOverviewModel>[].obs;
  RxList<ExpenseModel> expenseRecordsByDate = <ExpenseModel>[].obs;
  RxInt clinicId = 1.obs;
  RxBool reportsLoading = false.obs;

  @override
  void onInit() {
    clinicId.value = _clinicController.clinicId.value;
    super.onInit();
    getIncomeExpenseWeekday();
  }

// ------------------- Get Income Expense Overview ------------ //
  Future<void> getIncomeExpenseWeekday() async {
    try {
      reportsLoading.value = true;
      final response =
          await _reportsApi.getIncomeExpenseWeekday(clinicId.value);
      if (response.statusCode == 200 && response.body != null) {
        incomeExpenseOverview.clear();
        incomeExpenseOverview.value = response.body!;
      }
    } finally {
      reportsLoading.value = false;
    }
  }

  Future<void> getIncomeExpense15Days() async {
    try {
      reportsLoading.value = true;
      final response = await _reportsApi.getIncomeExpense15Days(clinicId.value);
      if (response.statusCode == 200 && response.body != null) {
        incomeExpenseOverview.clear();
        incomeExpenseOverview.value = response.body!;
      }
    } finally {
      reportsLoading.value = false;
    }
  }

  Future<void> getIncomeExpenseMonthly() async {
    try {
      reportsLoading.value = true;
      final response =
          await _reportsApi.getIncomeExpenseMonthly(clinicId.value);
      if (response.statusCode == 200 && response.body != null) {
        incomeExpenseOverview.clear();
        incomeExpenseOverview.value = response.body!;
      }
    } finally {
      reportsLoading.value = false;
    }
  }

  Future<void> getIncomeExpenseYearly() async {
    try {
      reportsLoading.value = true;
      final response = await _reportsApi.getIncomeExpenseYearly(clinicId.value);
      if (response.statusCode == 200 && response.body != null) {
        incomeExpenseOverview.clear();
        incomeExpenseOverview.value = response.body!;
      }
    } finally {
      reportsLoading.value = false;
    }
  }

  Future<void> getIncomeReferralByDate(String fromDate, String toDate) async {
    try {
      reportsLoading.value = true;
      final response = await _reportsApi.getIncomeReferralDate(
          clinicId.value, fromDate, toDate);
      if (response.statusCode == 200 && response.body != null) {
        incomeReferralByDate.clear();
        incomeReferralByDate.value = response.body!;
      }
    } finally {
      reportsLoading.value = false;
    }
  }

  Future<void> getExpenseOverviewByDate(String fromDate, String toDate) async {
    try {
      reportsLoading.value = true;
      final response = await _reportsApi.getExpenseOverviewDate(
          clinicId.value, fromDate, toDate);
      if (response.statusCode == 200 && response.body != null) {
        expenseOverviewByDate.clear();
        expenseOverviewByDate.value = response.body!;
      }
    } finally {
      reportsLoading.value = false;
    }
  }

  Future<void> getExpenseQueryByDate(String fromDate, String toDate) async {
    try {
      reportsLoading.value = true;
      final response = await _reportsApi.getExpenseQueryByDate(
          clinicId.value, fromDate, toDate);
      if (response.statusCode == 200 && response.body != null) {
        expenseRecordsByDate.clear();
        expenseRecordsByDate.value = response.body!;
      }
    } finally {
      reportsLoading.value = false;
    }
  }
}
