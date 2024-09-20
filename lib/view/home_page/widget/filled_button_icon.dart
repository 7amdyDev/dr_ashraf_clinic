import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/book_now_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              ? const TextStyle(
                  fontFamily: 'ElMessiri',
                  fontSize: 28,
                )
              : const TextStyle(
                  fontFamily: 'NotoNaskh',
                  fontSize: 28,
                )),
    );
  }
}
