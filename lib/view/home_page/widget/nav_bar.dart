import 'package:dr_ashraf_clinic/view/home_page/widget/change_lang_button_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/clinic_name_logo.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/nav_bar_button.dart';
import 'package:flutter/material.dart';

class HNavBar extends StatelessWidget {
  const HNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Row(children: [
        ClinicNameLogo(),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NavBarButton(
                text: 'main_button',
                fontSize: 20,
              ),
              NavBarButton(
                text: 'clinic_button',
                fontSize: 20,
                route: '/clinic',
              ),
              NavBarButton(
                text: 'contact_button',
                fontSize: 20,
                route: '/contact_us',
              ),
              ChangeLangButton(),
            ],
          ),
        ),
      ]),
    );
  }
}
