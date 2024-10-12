import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button_icon.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/nav_bar.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/rectangle_image_shadow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = HelperFunctions.screenSize();
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
                    const HNavBar(),
                    const SizedBox(
                      height: HSizes.spaceBtwSections * 2,
                    ),
                    LayoutBuilder(builder: (context, constraint) {
                      if (constraint.maxWidth > 450) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: _buildChildren(maxPageWidth, size),
                        );
                      } else {
                        return SingleChildScrollView(
                          child: SizedBox(
                            height: size.height * 0.6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: _buildChildren(maxPageWidth, size),
                            ),
                          ),
                        );
                      }
                    }),
                    const SizedBox(
                      height: HSizes.spaceBtwSections,
                    ),
                    const FilledButtonWithIcon()
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

List<Widget> _buildChildren(double maxPageWidth, Size size) {
  return [
    Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              softWrap: true,
              textAlign: TextAlign.center,
              'doctor_details'.tr,
              style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: maxPageWidth * 0.03,
                  color: HColors.textTitle,
                  shadows: const [
                    BoxShadow(
                        color: Colors.black38,
                        blurRadius: 2.0,
                        offset: Offset(0, 2))
                  ],
                  fontWeight: FontWeight.bold),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              softWrap: true,
              'doctor_details2'.tr,
              style: HelperFunctions.isLocalEnglish()
                  ? TextStyle(
                      height: 2,
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.w500,
                      color: HColors.black,
                      fontSize: maxPageWidth * 0.02,
                    )
                  : TextStyle(
                      height: 1.5,
                      fontFamily: 'Tajawal',
                      fontSize: maxPageWidth * 0.02,
                      color: HColors.black,
                      fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
    const SizedBox(
      width: HSizes.spaceBtwItems,
    ),
    RectangleImage(
      imagePath: 'assets/images/banner.jpg',
      width: size.width / 2.5,
      height: size.width / 2.5,
    ),
  ];
}
