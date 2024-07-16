import 'package:dr_ashraf_clinic/view/clinic/clinic_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/clinic_expenses_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/daily_income_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/patient_finance.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/patient/new_patient_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/patient/patient_search_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reception_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/reservation_page.dart';
import 'package:dr_ashraf_clinic/view/home_page/home_page.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(name: '/', page: () => const HomePage()),
  GetPage(name: '/clinic', page: () => const ClinicPage()),
  GetPage(name: '/reception', page: () => const ReceptionPage()),
  GetPage(name: '/newPatient', page: () => const NewPatientPage()),
  GetPage(name: '/patientSearch', page: () => const PatientSearchPage()),
  GetPage(name: '/dialyIncome', page: () => const DailyIcomePage()),
  GetPage(name: '/patientFinance', page: () => const PatientFinance()),
  GetPage(name: '/clinicExpenses', page: () => const ClinicExpensesPage()),
  GetPage(name: '/reserve', page: () => const ReservationPage()),
];
