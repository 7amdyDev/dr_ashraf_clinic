import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/book_now_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FilledButtonWithIcon extends StatelessWidget {
  const FilledButtonWithIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      iconAlignment: IconAlignment.end,
      icon: const Icon(
        Icons.arrow_downward_outlined,
      ),
      onPressed: () {
        Get.bottomSheet(const BookNowSheet());
      },
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16), elevation: 5),
      label: Text('book_button'.tr,
          style: HelperFunctions.isLocalEnglish()
              ? GoogleFonts.elMessiri(fontSize: 28)
              : GoogleFonts.notoNaskhArabic(fontSize: 28)),
    );
  }
}
