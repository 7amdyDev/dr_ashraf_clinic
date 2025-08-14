import 'package:dr_ashraf_clinic/view/clinic/clinic_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/doctor_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/clinic_expenses_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/daily_income_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/patient_finance.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/patient/new_patient_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/patient/patient_search_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reception_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/reservation_page.dart';
import 'package:dr_ashraf_clinic/view/contact_us/contact_us_page.dart';
import 'package:dr_ashraf_clinic/view/mobile/contact_us/mobile_contact_page.dart';
import 'package:dr_ashraf_clinic/view/home_page/home_page.dart';
import 'package:dr_ashraf_clinic/view/mobile/videos/mobile_video_page.dart';
import 'package:dr_ashraf_clinic/view/video_page/video_page.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(name: '/', page: () => const HomePage()),
  GetPage(name: '/clinic', page: () => const ClinicPage()),
  GetPage(name: '/reception', page: () => ReceptionPage()),
  GetPage(name: '/newPatient', page: () => const NewPatientPage()),
  GetPage(name: '/patientSearch', page: () => const PatientSearchPage()),
  GetPage(name: '/dialyIncome', page: () => DailyIncomePage()),
  GetPage(name: '/patientFinance', page: () => PatientFinance()),
  GetPage(name: '/clinicExpenses', page: () => const ClinicExpensesPage()),
  GetPage(name: '/reserve', page: () => ReservationPage()),
  GetPage(name: '/doctor', page: () => DoctorPage()),
  GetPage(name: '/contact_us', page: () => const ContactUsPage()),
  GetPage(name: '/mobile_contact_us', page: () => const MobileContactPage()),
  GetPage(name: '/mobile_video', page: () => const MobileVideoPage()),
  GetPage(name: '/video_page', page: () => const VideoPage()),
];
