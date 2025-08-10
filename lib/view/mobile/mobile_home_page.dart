import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/calender_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/clinic_contact_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/facebook_video_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/page_title_widget.dart';
import 'package:dr_ashraf_clinic/view/mobile/Widget/doctor_profile_widget.dart';
import 'package:dr_ashraf_clinic/view/mobile/Widget/mobile_app_bar.dart';
import 'package:dr_ashraf_clinic/view/mobile/Widget/mobile_drawer.dart';
import 'package:dr_ashraf_clinic/view/mobile/Widget/social_media_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HColors.primaryBackground,
      endDrawer: mobileDrawer(context),
      body: Center(
        heightFactor: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),

          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) => Column(
              children: [
                MobileAppbar(),
                SizedBox(height: HSizes.spaceBtwSections),
                DoctorProfile(),
                SizedBox(height: HSizes.spaceBtwSections),
                Divider(color: HColors.darkGrey, thickness: 1),
                SizedBox(height: HSizes.spaceBtwSections),
                CalendarWidget(),
                SizedBox(height: HSizes.spaceBtwItems),
                Divider(color: HColors.darkGrey, thickness: 1),
                SizedBox(height: HSizes.spaceBtwSections),
                SocialMediaWidget(),
                SizedBox(height: HSizes.spaceBtwSections),
                Divider(color: HColors.darkGrey, thickness: 1),
                SizedBox(height: HSizes.spaceBtwSections),
                PageTitleWidget(text: 'newest_videos_label'.tr),
                SizedBox(height: HSizes.spaceBtwItems),
                const FacebookvideoWidget(showAllVideos: false),
                SizedBox(height: HSizes.spaceBtwSections),
                Divider(color: HColors.darkGrey, thickness: 1),
                SizedBox(height: HSizes.spaceBtwSections),
                PageTitleWidget(text: 'contact_button'.tr),
                SizedBox(height: HSizes.spaceBtwItems),
                const ClinicContactWidget(),
                SizedBox(height: HSizes.spaceBtwItems),
                Divider(color: HColors.darkGrey, thickness: 1),
                SizedBox(height: HSizes.spaceBtwSections),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
