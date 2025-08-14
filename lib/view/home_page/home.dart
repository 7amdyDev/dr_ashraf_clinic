import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/calender_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/clinic_contact_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/copyrights_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/facebook_video_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/nav_bar.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/page_title_widget.dart';
import 'package:dr_ashraf_clinic/view/mobile/Widget/doctor_profile_widget.dart';
import 'package:dr_ashraf_clinic/view/mobile/Widget/social_media_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
              child: Column(
                children: [
                  HNavBar(),
                  const SizedBox(height: HSizes.spaceBtwSections * 2),
                  MobileDoctorProfile(isDesktopView: true),
                  const SizedBox(height: HSizes.spaceBtwSections),
                  Divider(color: HColors.darkGrey, thickness: 1),
                  SizedBox(height: HSizes.spaceBtwSections),
                  CalendarWidget(isDesktopView: true),
                  SizedBox(height: HSizes.spaceBtwItems),
                  Divider(color: HColors.darkGrey, thickness: 1),
                  SizedBox(height: HSizes.spaceBtwSections),
                  SocialMediaWidget(),
                  SizedBox(height: HSizes.spaceBtwSections),
                  Divider(color: HColors.darkGrey, thickness: 1),
                  SizedBox(height: HSizes.spaceBtwSections),
                  PageTitleWidget(text: 'newest_videos_label'.tr),
                  SizedBox(height: HSizes.spaceBtwItems),
                  const FacebookvideoWidget(
                    showAllVideos: false,
                    desktopView: true,
                  ),
                  SizedBox(height: HSizes.spaceBtwSections),
                  Divider(color: HColors.darkGrey, thickness: 1),
                  SizedBox(height: HSizes.spaceBtwSections),
                  PageTitleWidget(text: 'contact_button'.tr),
                  SizedBox(height: HSizes.spaceBtwItems),
                  const ClinicContactWidget(desktopView: true),

                  SizedBox(height: HSizes.spaceBtwSections),
                  const CopyrightsWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
