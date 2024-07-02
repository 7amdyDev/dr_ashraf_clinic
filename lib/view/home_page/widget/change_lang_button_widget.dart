import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeLangButton extends StatelessWidget {
  const ChangeLangButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        var newLocale = HelperFunctions.isLocalEnglish()
            ? const Locale('ar', 'EG')
            : const Locale('en', 'US');
        Get.updateLocale(newLocale);
      },
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          HelperFunctions.isLocalEnglish() ? 'عربي' : 'English',
          style: GoogleFonts.elMessiri(
              fontSize: 24, fontWeight: FontWeight.bold, color: HColors.black),
        ),
      ),
    );
  }
}
