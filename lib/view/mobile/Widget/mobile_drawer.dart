import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/change_lang_button_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/nav_bar_button.dart';
import 'package:flutter/material.dart';

Widget mobileDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: HColors.primaryBackground,
    width: 150,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          SizedBox(
            height: 100,
            child: Align(
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.close,
                  size: 36,
                  color: HColors.primary,
                  shadows: [
                    Shadow(
                      color: HColors.darkerGrey,
                      offset: Offset(0, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          NavBarButton(text: 'main_button', fontSize: 20),
          // NavBarButton(text: 'blog_button', fontSize: 20, route: '/blog'),
          Divider(color: HColors.darkGrey, thickness: 1),
          const SizedBox(height: 20),
          NavBarButton(
            text: 'videos_button',
            fontSize: 20,
            route: '/mobile_video',
          ),
          Divider(color: HColors.darkGrey, thickness: 1),
          const SizedBox(height: 20),
          NavBarButton(
            text: 'contact_button',
            fontSize: 20,
            route: '/mobile_contact_us',
          ),
          Divider(color: HColors.darkGrey, thickness: 1),
          const SizedBox(height: 20),
          const ChangeLangButton(),
        ],
      ),
    ),
  );
}
