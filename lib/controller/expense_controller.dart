import 'package:dr_ashraf_clinic/model/expense_model.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:get/get.dart';

class ExpenseController extends GetxController {
  var expenseApi = Get.find<ExpenseApi>();
  RxBool expensesLoading = false.obs;
  RxInt expenseId = 0.obs;
  RxInt totalDailyExpenses = 0.obs;
  RxList<ExpenseModel> expenseslst = <ExpenseModel>[].obs;

  @override
  void onInit() {
    getExpensesList();
    super.onInit();
  }

  void refreshData() {
    int value = 0;
    for (var item in expenseslst) {
      value += item.value;
    }
    totalDailyExpenses.value = value;
  }

  Future<void> getExpensesList() async {
    await getExpensesByDate(HFormatter.formatDate(DateTime.now()));
    refreshData();
  }

  Future<ExpenseModel?> getExpenseById(int id) async {
    var response = await expenseApi.getById(id);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  Future<void> getExpensesByDate(String dateTime) async {
    expensesLoading.value = true;
    try {
      var response = await expenseApi.getByDate(dateTime);
      if (response.statusCode == 200) {
        expenseslst.value = response.body!;
      }
    } finally {
      expensesLoading.value = false;
    }
  }

  Future<void> createExpense(ExpenseModel expense) async {
    expensesLoading.value = true;
    try {
      var response = await expenseApi.create(expense);

      if (response.statusCode == 201 && response.body != null) {
        expenseId.value = (response.body!.id!);
        getExpensesList();
      }
    } finally {
      expensesLoading.value = false;
    }
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    expensesLoading.value = true;
    try {
      var response = await expenseApi.update(expense);
    } finally {
      expensesLoading.value = false;
    }
  }

  Future<void> removeExpense(int id) async {
    expensesLoading.value = true;
    try {
      var response = await expenseApi.remove(id);
      if (response.statusCode == 200) {
        getExpensesList();
      }
    } finally {
      expensesLoading.value = false;
    }
  }
}

class ExpenseApi extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = 'http://localhost:8080';
    httpClient.defaultContentType = 'application/json; charset=UTF-8';
  }

  Future<Response<List<ExpenseModel>>> getAll() =>
      get('/expenses', decoder: ExpenseModel.listFromJson);

  Future<Response<ExpenseModel>> getById(int id) =>
      get('/expenses/$id', decoder: ExpenseModel.fromJson);

  Future<Response<List<ExpenseModel>>> getByDate(String dateTime) =>
      get('/expenses/date/$dateTime', decoder: ExpenseModel.listFromJson);

  Future<Response<ExpenseModel>> create(ExpenseModel expense) =>
      post('/expenses', expense.toJson(), decoder: ExpenseModel.fromJson);

  Future<Response<ExpenseModel>> update(ExpenseModel expense) =>
      put('/expenses/${expense.id}', expense.toJson(),
          decoder: ExpenseModel.fromJson);

  Future<Response> remove(int id) => delete('/expenses/$id');
}
