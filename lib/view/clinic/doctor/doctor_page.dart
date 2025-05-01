import 'package:dr_ashraf_clinic/controller/auth_controller.dart';
import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/model/pages_list.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/clinic/clinic_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/widget/doctor_navigation_drawer.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/change_lang_button_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/clinic_name_logo.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/copyrights_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorPage extends StatelessWidget {
  DoctorPage({super.key});
  final controller = Get.find<ClinicController>();
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    controller.getOnlineReservationData();
    // double maxPageWidth = HSizes.maxPageWidth;
    return Obx(() => authController.user.value != null
        ? Scaffold(
            backgroundColor: !controller.scheduleByDate.value
                ? HColors.secondary
                : HColors.primary.withValues(alpha: 0.2),
            body: Center(
              heightFactor: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: HelperFunctions.clinicPagesWidth()),
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
                            const HDoctorNavigationDrawer(),
                            Expanded(
                              child: Obx(
                                  () => pagesList[controller.pageIndex.value]),
                            )
                          ],
                        ),
                      ),
                      const CopyrightsWidget(),
                    ],
                  ),
                ),
              ),
            ))
        : const ClinicPage());
  }
}
