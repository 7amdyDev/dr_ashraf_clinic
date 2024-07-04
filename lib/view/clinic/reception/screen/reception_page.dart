import 'package:dr_ashraf_clinic/model/clinic_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/reception_schedule_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/navigation_drawer.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/change_lang_button_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/clinic_name_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReceptionPage extends StatelessWidget {
  const ReceptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = HelperFunctions.screenSize();
    final controller = Get.put(ClinicController());
    double maxPageWidth = HSizes.maxPageWidth;
    return Scaffold(
        backgroundColor: HColors.secondary,
        body: Center(
          heightFactor: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              constraints: BoxConstraints(maxWidth: maxPageWidth),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClinicNameLogo(),
                      ChangeLangButton(),
                    ],
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        Obx(
                          () => HNavigationDrawer(
                              isCollapsed: controller.isCollapsed.value),
                        ),
                        Expanded(
                          child: GestureDetector(
                              onTap: () {
                                (!controller.isCollapsed.value)
                                    ? controller.updateCollapsed(true)
                                    : null;
                              },
                              child: const ReceptionSchedulePage()),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
