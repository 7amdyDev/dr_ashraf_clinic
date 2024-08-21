import 'package:dr_ashraf_clinic/model/finance_models.dart';
import 'package:get/get.dart';

class RevenueApi extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = 'http://localhost:8080';
    httpClient.defaultContentType = 'application/json; charset=UTF-8';
  }

  Future<Response<List<RevenueAccounts>>> getAll() =>
      get('/revenues', decoder: RevenueAccounts.listFromJson);

  Future<Response<RevenueAccounts>> getById(int id) =>
      get('/revenues/$id', decoder: RevenueAccounts.fromJson);

  Future<Response<List<RevenueAccounts>>> getByDate(String dateTime) =>
      get('/revenues/date/$dateTime', decoder: RevenueAccounts.listFromJson);

  Future<Response<RevenueAccounts>> create(RevenueAccounts asset) =>
      post('/revenues', asset.toJson(), decoder: RevenueAccounts.fromJson);

  Future<Response<RevenueAccounts>> update(RevenueAccounts asset) =>
      put('/revenues/${asset.id}', asset.toJson(),
          decoder: RevenueAccounts.fromJson);

  Future<Response> remove(int id) => delete('/revenues/$id');
}
