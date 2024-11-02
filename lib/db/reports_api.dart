import 'package:dr_ashraf_clinic/model/expense_model.dart';
import 'package:dr_ashraf_clinic/model/reports_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/api_constants.dart';
import 'package:get/get.dart';

class ReportsApi extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = apiUrl;
    httpClient.defaultContentType = 'application/json; charset=UTF-8';
  }

  Future<Response<List<IncomeExpenseModel>>> getIncomeExpenseWeekday(
          int clinicId) =>
      get('/reports/incomeExpenseWeekday/$clinicId',
          decoder: IncomeExpenseModel.listFromJson);

  Future<Response<List<IncomeExpenseModel>>> getIncomeExpense15Days(
          int clinicId) =>
      get('/reports/incomeExpense15Days/$clinicId',
          decoder: IncomeExpenseModel.listFromJson);

  Future<Response<List<IncomeExpenseModel>>> getIncomeExpenseMonthly(
          int clinicId) =>
      get('/reports/incomeExpenseMonthly/$clinicId',
          decoder: IncomeExpenseModel.listFromJson);

  Future<Response<List<IncomeExpenseModel>>> getIncomeExpenseYearly(
          int clinicId) =>
      get('/reports/incomeExpenseYearly/$clinicId',
          decoder: IncomeExpenseModel.listFromJson);

  Future<Response<List<IncomeReferralModel>>> getIncomeReferralDate(
          int clinicId, String fromDate, String toDate) =>
      get('/reports/incomeReferralByDate/$clinicId/$fromDate/$toDate',
          decoder: IncomeReferralModel.listFromJson);

  Future<Response<List<ExpenseOverviewModel>>> getExpenseOverviewDate(
          int clinicId, String fromDate, String toDate) =>
      get('/reports/ExpenseOverviewByDate/$clinicId/$fromDate/$toDate',
          decoder: ExpenseOverviewModel.listFromJson);

  Future<Response<List<ExpenseModel>>> getExpenseQueryByDate(
          int clinicId, String fromDate, String toDate) =>
      get('/reports/ExpenseQueryByDate/$clinicId/$fromDate/$toDate',
          decoder: ExpenseModel.listFromJson);
}
