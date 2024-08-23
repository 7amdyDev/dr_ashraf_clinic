import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/new_check_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/clinic_expenses_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/daily_income_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/patient_finance.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/patient/new_patient_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/patient/patient_search_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/reservation_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/reception_schedule_page.dart';

List receptionPagesList = [
  ReceptionSchedulePage(),
  ReservationPage(),
  const NewPatientPage(),
  const PatientSearchPage(),
  DailyIncomePage(),
  PatientFinance(),
  const ClinicExpensesPage(),
];

List doctorPagesList = [
  ReceptionSchedulePage(),
  ReservationPage(),
  const NewPatientPage(),
  const PatientSearchPage(),
  DailyIncomePage(),
  PatientFinance(),
  const ClinicExpensesPage(),
  const NewCheckPage(),
];
