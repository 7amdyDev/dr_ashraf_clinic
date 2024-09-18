import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/db/expense_api.dart';
import 'package:dr_ashraf_clinic/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseController extends GetxController {
  final _expenseApi = Get.find<ExpenseApi>();
  RxBool expensesLoading = false.obs;
  RxInt expenseId = 0.obs;
  RxInt totalDailyExpenses = 0.obs;
  RxList<ExpenseModel> expenseslst = <ExpenseModel>[].obs;
  final _clinicController = Get.find<ClinicController>();
  @override
  void onInit() {
    getExpensesList();
    super.onInit();
  }

  Future<void> getExpensesList() async {
    await getExpensesByDate(DateUtils.dateOnly(DateTime.now()));
    await getTotalDailyExpenses();
  }

  Future<void> getExpensesByDate(DateTime date) async {
    expensesLoading.value = true;
    try {
      var response =
          await _expenseApi.getByDate(_clinicController.clinicId.value, date);
      if (response.statusCode == 200) {
        expenseslst.value = response.body!;
      }
    } finally {
      expensesLoading.value = false;
    }
  }

  Future<void> getTotalDailyExpenses() async {
    expensesLoading.value = true;
    try {
      var response = await _expenseApi
          .getTotalDailyExpenses(_clinicController.clinicId.value);
      if (response.statusCode == 200 && response.body != null) {
        totalDailyExpenses.value = response.body!.total!;
      } else {
        totalDailyExpenses.value = 0;
      }
    } finally {
      expensesLoading.value = false;
    }
  }

  Future<void> createExpense(ExpenseModel expense) async {
    expensesLoading.value = true;
    try {
      var response = await _expenseApi.create(expense);

      if (response.statusCode == 201 && response.body != null) {
        expenseId.value = (response.body!.id!);
        getExpensesList();
      }
    } finally {
      expensesLoading.value = false;
    }
  }

  Future<void> removeExpense(int id) async {
    expensesLoading.value = true;
    try {
      var response = await _expenseApi.remove(id);
      if (response.statusCode == 200) {
        getExpensesList();
      }
    } finally {
      expensesLoading.value = false;
    }
  }
}
