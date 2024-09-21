import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/nav_bar.dart';
import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: HColors.primaryBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const HNavBar(),
          const SizedBox(
            height: HSizes.spaceBtwSections,
          ),
          Image(
            fit: BoxFit.scaleDown,
            width: size.width * 0.8,
            height: size.height * 0.8,
            image: const AssetImage(
              'assets/images/contact.png',
            ),
          ),
        ],
      ),
    );
  }
}
