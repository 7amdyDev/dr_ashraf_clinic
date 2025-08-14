import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/clinic_contact_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/copyrights_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/nav_bar.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/page_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var maxWidth = HelperFunctions.clinicPagesWidth();
    return Scaffold(
      backgroundColor: HColors.primaryBackground,
      body: Center(
        heightFactor: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),

          child: SingleChildScrollView(
            child: Column(
              children: [
                HNavBar(),
                SizedBox(height: HSizes.spaceBtwSections * 2),
                PageTitleWidget(text: 'contact_button'.tr),
                SizedBox(height: HSizes.spaceBtwSections),
                Divider(color: HColors.darkGrey, thickness: 1),
                SizedBox(height: HSizes.spaceBtwSections * 2),
                Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: ClinicContactWidget(desktopView: true),
                ),
                SizedBox(height: HSizes.spaceBtwSections),
                const CopyrightsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
