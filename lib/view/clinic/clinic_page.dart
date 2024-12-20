import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/drop_down_menu.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/nav_bar.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/rectangle_image_shadow.dart';
import 'package:flutter/material.dart';

class ClinicPage extends StatelessWidget {
  const ClinicPage({super.key});

  @override
  Widget build(BuildContext context) {
    double maxPageWidth = HelperFunctions.clinicPagesWidth();
    return Scaffold(
        backgroundColor: HColors.primaryBackground,
        body: Center(
            heightFactor: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                constraints: BoxConstraints(maxWidth: maxPageWidth),
                child: SingleChildScrollView(
                  primary: true,
                  child: Column(
                    children: [
                      const HNavBar(),
                      const SizedBox(
                        height: HSizes.spaceBtwSections * 2,
                      ),
                      RectangleImage(
                          width: maxPageWidth / 3,
                          height: maxPageWidth / 3.5,
                          shadow: false,
                          imagePath: 'assets/images/Personal.png'),
                      const SizedBox(
                        height: HSizes.spaceBtwSections,
                      ),
                      const HDropDownMenu(),
                    ],
                  ),
                ),
              ),
            )));
  }
}
