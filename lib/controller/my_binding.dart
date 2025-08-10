import 'package:dr_ashraf_clinic/controller/appointment_controller.dart';
import 'package:dr_ashraf_clinic/controller/auth_controller.dart';
import 'package:dr_ashraf_clinic/controller/clinic_contact_controller.dart';
import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/controller/consultation_controller.dart';
import 'package:dr_ashraf_clinic/controller/doctor_info_controller.dart';
import 'package:dr_ashraf_clinic/controller/expense_controller.dart';
import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/controller/reports_controller.dart';
import 'package:dr_ashraf_clinic/controller/reservation_limit_controller.dart';
import 'package:dr_ashraf_clinic/controller/social_buttons_controller.dart';
import 'package:dr_ashraf_clinic/controller/videos_controller.dart';
import 'package:dr_ashraf_clinic/db/appointment_api.dart';
import 'package:dr_ashraf_clinic/db/asset_api.dart';
import 'package:dr_ashraf_clinic/db/clinic_api.dart';
import 'package:dr_ashraf_clinic/db/consultation_api.dart';
import 'package:dr_ashraf_clinic/db/doctor_info_api.dart';
import 'package:dr_ashraf_clinic/db/expense_api.dart';
import 'package:dr_ashraf_clinic/db/patient_api.dart';
import 'package:dr_ashraf_clinic/db/reports_api.dart';
import 'package:dr_ashraf_clinic/db/revenue_api.dart';
import 'package:dr_ashraf_clinic/service/socket_service.dart';
import 'package:get/get.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<DoctorInfoApi>(DoctorInfoApi(), permanent: true);
    Get.put(ExpenseApi(), permanent: true);
    Get.put(PatientApi(), permanent: true);
    Get.put(ConsultationApi(), permanent: true);
    Get.put(AppointmentApi(), permanent: true);
    Get.put(AssetApi(), permanent: true);
    Get.put(RevenueApi(), permanent: true);
    Get.put(ClinicApi(), permanent: true);
    Get.put(ClinicController(), permanent: true);
    Get.put(AuthController(), permanent: true);
    Get.put(ReportsApi(), permanent: true);
    Get.put(SocketService(), permanent: true);
    Get.lazyPut(() => ReservationLimitController(), fenix: true);
    Get.lazyPut(() => VideoController(), fenix: true);
    Get.lazyPut(() => ClinicContactController(), fenix: true);
    Get.lazyPut(() => DoctorController(), fenix: true);
    Get.lazyPut(() => SocialButtonsController(), fenix: true);
    Get.lazyPut(() => AppointmentController(), fenix: true);
    Get.lazyPut(() => ExpenseController(), fenix: true);
    Get.lazyPut(() => FinanceController(), fenix: true);
    Get.lazyPut(() => PatientController(), fenix: true);
    Get.lazyPut(() => ConsultationController(), fenix: true);
    Get.lazyPut(() => ReportsController(), fenix: true);
  }
}
