import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/clinic_name_logo.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/nav_bar_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HNavBar extends StatelessWidget {
  const HNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(children: [
        const ClinicNameLogo(),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const NavBarButton(
                text: 'main_button',
                fontSize: 24,
              ),
              const NavBarButton(
                text: 'clinic_button',
                fontSize: 24,
                route: '/clinic',
              ),
              const NavBarButton(
                text: 'contact_button',
                fontSize: 24,
                route: '/contact_us',
              ),
              TextButton(
                onPressed: () {
                  var newLocale = HelperFunctions.isLocalEnglish()
                      ? const Locale('ar', 'EG')
                      : const Locale('en', 'US');
                  Get.updateLocale(newLocale);
                },
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    HelperFunctions.isLocalEnglish() ? 'عربي' : 'English',
                    style: GoogleFonts.elMessiri(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: HColors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
