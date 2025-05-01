import 'package:dr_ashraf_clinic/model/expense_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/api_constants.dart';
import 'package:get/get.dart';

class ExpenseApi extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = apiUrl;
    httpClient.defaultContentType = 'application/json; charset=UTF-8';
  }

  Future<Response<List<ExpenseModel>>> getAll() =>
      get('/expenses', decoder: ExpenseModel.listFromJson);

  Future<Response<ExpenseModel>> getById(int id) =>
      get('/expenses/$id', decoder: ExpenseModel.fromJson);

  Future<Response<TotalExpenses>> getTotalDailyExpenses(
          int clinicId, String dateTime) =>
      get('/expenses/totalDailyExpenses/$clinicId/$dateTime',
          decoder: TotalExpenses.fromJson);

  Future<Response<List<ExpenseModel>>> getByDate(int clinicId, DateTime date) =>
      get('/expenses/date/$clinicId/$date', decoder: ExpenseModel.listFromJson);

  Future<Response<ExpenseModel>> create(ExpenseModel expense) =>
      post('/expenses', expense.toJson(), decoder: ExpenseModel.fromJson);

  Future<Response<ExpenseModel>> update(ExpenseModel expense) =>
      put('/expenses/${expense.id}', expense.toJson(),
          decoder: ExpenseModel.fromJson);

  Future<Response> remove(int id) => delete('/expenses/$id');
}
