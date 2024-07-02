import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationDrawerItem extends StatelessWidget {
  const NavigationDrawerItem({
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
        : ListTile(
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
            onTap: onPressed);
  }
}
