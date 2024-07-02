import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationDrawerExpandedItem extends StatelessWidget {
  const NavigationDrawerExpandedItem({
    super.key,
    required this.isCollapsed,
    required this.imagePath,
    required this.title,
    required this.onPressed,
  });
  final bool isCollapsed;
  final String imagePath;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return isCollapsed
        ? InkWell(
            onTap: onPressed,
            child: Image(
              image: AssetImage(imagePath),
            ),
          )
        : ExpansionTile(
            tilePadding: const EdgeInsets.all(8),
            initiallyExpanded: true,
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                  style: GoogleFonts.tajawal(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  title.tr),
            ),
            leading: Image(
              width: 50,
              height: 50,
              image: AssetImage(imagePath),
            ),
            children: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                        style: GoogleFonts.tajawal(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        'daily_revenue_label'.tr),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                        style: GoogleFonts.tajawal(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        'patient_finance_label'.tr),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                        style: GoogleFonts.tajawal(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        'clinic_expenses_label'.tr),
                  ),
                ),
              ),
            ],
          );
  }
}
