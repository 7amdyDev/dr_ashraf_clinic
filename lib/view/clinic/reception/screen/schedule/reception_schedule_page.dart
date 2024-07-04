import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/schedule_table_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ReceptionSchedulePage extends StatelessWidget {
  const ReceptionSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: HSizes.spaceBtwItems,
        ),
        Text(
          'schedule_table_label'.tr,
          style: GoogleFonts.elMessiri(
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: HSizes.spaceBtwSections,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HFilledButton(text: 'today_label'.tr, onPressed: () {}),
            HFilledButton(text: 'choose_date_label'.tr, onPressed: () {}),
          ],
        ),
        const SizedBox(
          height: HSizes.spaceBtwItems,
        ),
        HScheduleDataTable(searchResult: [
          'ahmed',
          'Hamdy',
          'anas',
        ])
      ],
    );
  }
}
