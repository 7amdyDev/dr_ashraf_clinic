import 'package:dr_ashraf_clinic/view/home_page/widget/change_lang_button_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/clinic_name_logo.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/nav_bar_button.dart';
import 'package:flutter/material.dart';

class HNavBar extends StatelessWidget {
  const HNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          const ClinicNameLogo(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavBarButton(
                  text: 'main_button',
                  fontSize: width > 700 ? 20 : 10,
                ),
                width > 750
                    ? const NavBarButton(
                        text: 'clinic_button',
                        fontSize: 20,
                        route: '/clinic',
                      )
                    : Container(),
                NavBarButton(
                  text: 'blog_button',
                  fontSize: width > 700 ? 20 : 10,
                  route: '/blog',
                ),
                NavBarButton(
                  text: 'videos_button',
                  fontSize: width > 700 ? 20 : 10,
                  route: '/videos',
                ),
                NavBarButton(
                  text: 'contact_button',
                  fontSize: width > 700 ? 20 : 10,
                  route: '/contact_us',
                ),
                const ChangeLangButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
