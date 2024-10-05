import 'package:dr_ashraf_clinic/model/clinic_models.dart';
import 'package:dr_ashraf_clinic/utils/constants/api_constants.dart';
import 'package:get/get.dart';

class ClinicApi extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = apiUrl;
    httpClient.defaultContentType = 'application/json; charset=UTF-8';
  }

  Future<Response<List<ServicesId>>> getServices() =>
      get('/getServices', decoder: ServicesId.listFromJson);

  Future<Response<List<AccountsId>>> getExpensesId() =>
      get('/getExpensesId', decoder: AccountsId.listFromJson);

  Future<Response<List<Fee>>> getFee() =>
      get('/getFee', decoder: Fee.listFromJson);

  Future<Response<List<ClinicId>>> getClinicBranches() =>
      get('/getBranches', decoder: ClinicId.listFromJson);

  Future<Response<List<Fee>>> updateFee(Fee fee) =>
      put('/fee/${fee.id}', fee.toJson(), decoder: Fee.listFromJson);

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
