import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/facebook_video_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/page_title_widget.dart';
import 'package:dr_ashraf_clinic/view/mobile/Widget/mobile_app_bar.dart';
import 'package:dr_ashraf_clinic/view/mobile/Widget/mobile_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileVideoPage extends StatelessWidget {
  const MobileVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                PageTitleWidget(text: 'videos_button'.tr),
                SizedBox(height: HSizes.spaceBtwSections),
                Divider(color: HColors.darkGrey, thickness: 1),
                SizedBox(height: HSizes.spaceBtwSections),
                FacebookvideoWidget(showAllVideos: true),
                SizedBox(height: HSizes.spaceBtwSections),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
