import 'dart:async';
import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/db/expense_api.dart';
import 'package:dr_ashraf_clinic/model/expense_model.dart';
import 'package:dr_ashraf_clinic/service/socket_service.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseController extends GetxController {
  final _expenseApi = Get.find<ExpenseApi>();
  RxBool expensesLoading = false.obs;
  RxInt expenseId = 0.obs;
  RxInt totalDailyExpenses = 0.obs;
  RxList<ExpenseModel> expenseslst = <ExpenseModel>[].obs;
  final _clinicController = Get.find<ClinicController>();
  final _socketService = Get.find<SocketService>();

  @override
  void onInit() {
    ever(_clinicController.selectedDate, (value) {
      getExpensesList();
    });
    getExpenseEvents();
    super.onInit();
  }

  void getExpenseEvents() {
    getExpensesList();
    _socketService.socket.on('expense_created', (_) {
      Future.delayed(Durations.medium4, () {
        getExpensesList();
      });
    });
    _socketService.socket.on('expense_deleted', (_) {
      getExpensesList();
    });

    _socketService.socket.on('expense_updated', (_) {
      Future.delayed(Durations.medium4, () {
        getExpensesList();
      });
    });
  }

  Future<void> getExpensesList() async {
    await getExpensesByDate();
    await getTotalDailyExpenses();
  }

  Future<void> getExpensesByDate() async {
    (expensesLoading) {
      return;
    };
    expensesLoading.value = true;
    try {
      var response = await _expenseApi.getByDate(
          _clinicController.clinicId.value,
          DateUtils.dateOnly(_clinicController.selectedDate.value));
      if (response.statusCode == 200) {
        expenseslst.value = response.body!;
      }
    } finally {
      expensesLoading.value = false;
    }
  }

  Future<void> getTotalDailyExpenses() async {
    (expensesLoading) {
      return;
    };
    expensesLoading.value = true;
    try {
      var response = await _expenseApi.getTotalDailyExpenses(
          _clinicController.clinicId.value,
          HFormatter.formatDate(_clinicController.selectedDate.value,
              reversed: true));
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
