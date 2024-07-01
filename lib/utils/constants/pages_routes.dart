import 'package:dr_ashraf_clinic/view/clinic/clinic_page.dart';
import 'package:dr_ashraf_clinic/view/home_page/home_page.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(name: '/', page: () => const HomePage()),
  GetPage(name: '/clinic', page: () => const ClinicPage()),
  // GetPage(name: '/contact_us', page: () => ThirdScreen()),
];
