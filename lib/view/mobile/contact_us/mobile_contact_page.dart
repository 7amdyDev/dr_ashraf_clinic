import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/clinic_contact_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/page_title_widget.dart';
import 'package:dr_ashraf_clinic/view/mobile/Widget/mobile_app_bar.dart';
import 'package:dr_ashraf_clinic/view/mobile/Widget/mobile_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileContactPage extends StatelessWidget {
  const MobileContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    // const String apiKey = 'AIzaSyAtTO6Ow1iTU3kol0RGUtDudAWJ2Wr2z9c';
    // const String latitude = '31.087257970224154';
    // const String longitude = '29.750032811936236';
    // final String staticMapUrl =
    //     'https://maps.googleapis.com/maps/api/staticmap?'
    //     'center=$latitude,$longitude&'
    //     'zoom=14&'
    //     'size=400x300&'
    //     'markers=color:red%7C$latitude,$longitude&'
    //     'key=$apiKey';
    return Scaffold(
      backgroundColor: HColors.primaryBackground,
      endDrawer: mobileDrawer(context),
      body: Center(
        heightFactor: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),

          child: SingleChildScrollView(
            child: Column(
              children: [
                MobileAppbar(),
                SizedBox(height: HSizes.spaceBtwSections),
                PageTitleWidget(text: 'contact_button'.tr),
                SizedBox(height: HSizes.spaceBtwSections),
                Divider(color: HColors.darkGrey, thickness: 1),
                SizedBox(height: HSizes.spaceBtwSections),

                // SizedBox(height: 300, child: Image.network(staticMapUrl)),
                ClinicContactWidget(),
                SizedBox(height: HSizes.spaceBtwSections),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
