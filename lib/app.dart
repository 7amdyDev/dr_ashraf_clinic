import 'package:dr_ashraf_clinic/utils/constants/pages_routes.dart';
import 'package:dr_ashraf_clinic/utils/constants/text_strings.dart';
import 'package:dr_ashraf_clinic/utils/theme/theme.dart';
import 'package:dr_ashraf_clinic/utils/translation/translations.dart';
import 'package:dr_ashraf_clinic/view/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppTranslation(),
      locale: const Locale('ar', 'EG'),
      fallbackLocale: const Locale('en', 'US'),
      themeMode: ThemeMode.system,
      theme: HAppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      title: HTexts.appName,
      initialRoute: '/',
      getPages: routes,
      // initialBinding: RootBinding(),
      home: const HomePage(),
    );
  }
}
