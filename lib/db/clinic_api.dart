import 'package:dr_ashraf_clinic/model/clinic_models.dart';
import 'package:get/get.dart';

class ClinicApi extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = 'https://clinicnode.up.railway.app';
    httpClient.defaultContentType = 'application/json; charset=UTF-8';
  }

  Future<Response<List<ServicesId>>> getServices() =>
      get('/getServices', decoder: ServicesId.listFromJson);

  Future<Response<List<AccountsId>>> getExpensesId() =>
      get('/getExpensesId', decoder: AccountsId.listFromJson);

  // Future<Response<List<AssetAccountsModel>>> getByPatientId(int id) =>
  //     get('/assets/patient/$id', decoder: AssetAccountsModel.listFromJson);

  // Future<Response<List<AssetAccountsModel>>> getByDate(String dateTime) =>
  //     get('/assets/date/$dateTime', decoder: AssetAccountsModel.listFromJson);

  // Future<Response<AssetAccountsModel>> create(AssetAccountsModel asset) =>
  //     post('/assets', asset.toJson(), decoder: AssetAccountsModel.fromJson);

  // Future<Response<AssetAccountsModel>> update(AssetAccountsModel asset) =>
  //     put('/assets/${asset.id}', asset.toJson(),
  //         decoder: AssetAccountsModel.fromJson);

  // Future<Response> remove(int id) => delete('/assets/$id');
}
