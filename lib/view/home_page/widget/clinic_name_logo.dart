import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClinicNameLogo extends StatelessWidget {
  const ClinicNameLogo({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Get.toNamed('/'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              width: width > 800 ? 70 : width * .1,
              height: width > 800 ? 70 : width * .1,
              'assets/images/logo.png',
            ),
            const SizedBox(width: 16),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: OverflowBar(
                children: [
                  Text(
                    'app_name'.tr,
                    style: Get.locale == const Locale('en', 'US')
                        ? TextStyle(
                            fontFamily: 'Oswald',
                            fontWeight: FontWeight.bold,
                            shadows: const [
                              Shadow(
                                color: Colors.black38,
                                blurRadius: 4.0,
                                offset: Offset(0.0, 2.0),
                              ),
                            ],
                            fontSize: width > 800
                                ? 32
                                : (width * .05).clamp(0, 32).toDouble(),
                            color: HColors.primary,
                          )
                        : TextStyle(
                            fontFamily: 'ElMessiri',
                            fontWeight: FontWeight.w700,
                            shadows: const [
                              Shadow(
                                color: Colors.black38,
                                blurRadius: 4.0,
                                offset: Offset(0.0, 2.0),
                              ),
                            ],
                            fontSize: width > 800
                                ? 32
                                : (width * .05).clamp(0, 32).toDouble(),
                            color: HColors.primary,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
