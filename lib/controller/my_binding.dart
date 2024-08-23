import 'package:dr_ashraf_clinic/controller/appointment_controller.dart';
import 'package:dr_ashraf_clinic/controller/auth_controller.dart';
import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/controller/expense_controller.dart';
import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/db/appointment_api.dart';
import 'package:dr_ashraf_clinic/db/asset_api.dart';
import 'package:dr_ashraf_clinic/db/clinic_api.dart';
import 'package:dr_ashraf_clinic/db/expense_api.dart';
import 'package:dr_ashraf_clinic/db/patient_api.dart';
import 'package:dr_ashraf_clinic/db/revenue_api.dart';
import 'package:get/get.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ExpenseApi());
    Get.put(PatientApi());
    Get.put(AppointmentApi());
    Get.put(AssetApi());
    Get.put(RevenueApi());
    Get.put(ClinicApi());
    Get.put(ClinicController());
    Get.put(AuthController());
    Get.lazyPut(() => AppointmentController());
    Get.lazyPut(() => ExpenseController());
    Get.lazyPut(() => FinanceController());
    Get.lazyPut(() => PatientController());
  }
}