import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBarButton extends StatelessWidget {
  const NavBarButton({
    super.key,
    required this.text,
    this.color = HColors.black,
    this.fontSize = 28,
    this.withShadow = false,
    this.route = '/',
  });
  final String text;
  final Color color;
  final double fontSize;
  final bool withShadow;
  final String route;
  @override
  Widget build(BuildContext context) {
    bool currentPage = Get.currentRoute == route;
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: OverflowBar(children: [
        TextButton(
          onPressed: () {
            switch (route) {
              case '/':
                Get.toNamed('/');
                break;
              case '/clinic':
                Get.toNamed(route);
                break;
              case '/contact_us':
                Get.toNamed(route);
                break;
            }
          },
          child: Text(
            text.tr,
            style: Get.locale == const Locale('en', 'US')
                ? TextStyle(
                    fontFamily: 'Oswald',
                    fontWeight: currentPage ? FontWeight.bold : null,
                    shadows: withShadow
                        ? [
                            const Shadow(
                              color: Colors.black38,
                              blurRadius: 4.0,
                              offset: Offset(0.0, 2.0),
                            ),
                          ]
                        : null,
                    fontSize: fontSize,
                    color: color)
                : TextStyle(
                    fontFamily: 'ElMessiri',
                    fontWeight: currentPage ? FontWeight.bold : null,
                    shadows: withShadow
                        ? [
                            const Shadow(
                              color: Colors.black38,
                              blurRadius: 4.0,
                              offset: Offset(0.0, 2.0),
                            ),
                          ]
                        : null,
                    fontSize: fontSize,
                    color: color),
          ),
        ),
      ]),
    );
  }
}
