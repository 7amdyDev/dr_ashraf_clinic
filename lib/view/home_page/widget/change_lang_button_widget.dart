import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        child: Text(HelperFunctions.isLocalEnglish() ? 'عربي' : 'English',
            style: const TextStyle(
              fontFamily: 'ElMessiri',
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            )),
      ),
    );
  }
}
