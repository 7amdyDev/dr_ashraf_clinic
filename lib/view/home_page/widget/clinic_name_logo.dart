import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClinicNameLogo extends StatelessWidget {
  const ClinicNameLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          width: 70,
          height: 70,
          'assets/images/logo.png',
        ),
        const SizedBox(
          width: 16,
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: OverflowBar(children: [
            Text(
              'app_name'.tr,
              style: Get.locale == const Locale('en', 'US')
                  ? const TextStyle(
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black38,
                          blurRadius: 4.0,
                          offset: Offset(0.0, 2.0),
                        ),
                      ],
                      fontSize: 32,
                      color: HColors.primary)
                  : const TextStyle(
                      fontFamily: 'ElMessiri',
                      fontWeight: FontWeight.w700,
                      shadows: [
                        Shadow(
                          color: Colors.black38,
                          blurRadius: 4.0,
                          offset: Offset(0.0, 2.0),
                        ),
                      ],
                      fontSize: 32,
                      color: HColors.primary),
            ),
          ]),
        ),
      ],
    );
  }
}
