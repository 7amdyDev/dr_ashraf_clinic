import 'package:dr_ashraf_clinic/model/finance_models.dart';
import 'package:get/get.dart';

class AssetApi extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = 'http://localhost:8080';
    httpClient.defaultContentType = 'application/json; charset=UTF-8';
  }

  Future<Response<List<AssetAccountsModel>>> getAll() =>
      get('/assets', decoder: AssetAccountsModel.listFromJson);

  Future<Response<AssetAccountsModel>> getById(int id) =>
      get('/assets/$id', decoder: AssetAccountsModel.fromJson);

  Future<Response<List<AssetAccountsModel>>> getByPatientId(int id) =>
      get('/assets/patient/$id', decoder: AssetAccountsModel.listFromJson);

  Future<Response<List<AssetAccountsModel>>> getByAppointmetId(int id) =>
      get('/assets/appointment/$id', decoder: AssetAccountsModel.listFromJson);

  Future<Response<List<AssetAccountsModel>>> getByDate(String dateTime) =>
      get('/assets/date/$dateTime', decoder: AssetAccountsModel.listFromJson);

  Future<Response<List<AppointmentFinance>>> getPatientAppointmentFinance(
          int id) =>
      get('/assets/appointFinanceByPatient/$id',
          decoder: AppointmentFinance.listFromJson);

  Future<Response<List<AppointmentFinance>>> getAppointmentFinanceByDate(
          String date) =>
      get('/assets/appointFinanceByDate/$date',
          decoder: AppointmentFinance.listFromJson);

  Future<Response<List<AssetAccountsModel>>> getDailyIncomeList() =>
      get('/assets/dailyIncomeList', decoder: AssetAccountsModel.listFromJson);
  Future<Response<TotalIncome>> getTotalDailyIncome() =>
      get('/assets/totalDailyIncome', decoder: TotalIncome.fromJson);
  Future<Response<AssetAccountsModel>> create(AssetAccountsModel asset) =>
      post('/assets', asset.toJson(), decoder: AssetAccountsModel.fromJson);

  Future<Response<AssetAccountsModel>> update(AssetAccountsModel asset) =>
      put('/assets/${asset.id}', asset.toJson(),
          decoder: AssetAccountsModel.fromJson);

  Future<Response> remove(int id) => delete('/assets/$id');
}
