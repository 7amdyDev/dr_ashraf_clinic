import 'package:dr_ashraf_clinic/controller/auth_controller.dart';
import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/navigation_drawer_expanded_item.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/navigation_drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HDoctorNavigationDrawer extends StatelessWidget {
  const HDoctorNavigationDrawer({super.key, required this.isCollapsed});
  final bool isCollapsed;
  @override
  Widget build(BuildContext context) {
    final authcontroller = Get.put(AuthController());
    final size = HelperFunctions.screenSize();
    double maxPageWidth = HSizes.maxPageWidth;

    final controller = Get.put(ClinicController());
    double drawerWidth = size.width < maxPageWidth ? size.width * 0.22 : 200;
    return SizedBox(
      width: isCollapsed ? drawerWidth / 2.5 : drawerWidth,
      height: size.height * 0.9,
      child: Card(
        color: HColors.primaryBackground,
        elevation: 5,
        child: Drawer(
          backgroundColor: HColors.primaryBackground,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: HSizes.spaceBtwItems,
              ),
              NavigationDrawerItem(
                  isCollapsed: isCollapsed,
                  imagePath: 'assets/icons/calender.png',
                  title: 'appointment_label',
                  onPressed: () {
                    controller.doctorPageIndex.value = 0;
                    controller.updateCollapsed(true);
                  }),
              const Spacer(
                flex: 1,
              ),
              NavigationDrawerExpandedItem(
                isCollapsed: isCollapsed,
                imagePath: 'assets/icons/check.png',
                title: 'check_section_label',
                onPressed: () {
                  isCollapsed ? controller.updateCollapsed(false) : null;
                },
                children: [
                  DrawerTextButton(
                    text: 'new_check_label',
                    onPressed: () {
                      controller.doctorPageIndex.value = 7;
                      controller.updateCollapsed(true);
                    },
                  ),
                  DrawerTextButton(
                    text: 'search_patient_label',
                    onPressed: () {
                      controller.doctorPageIndex.value = 3;
                      controller.updateCollapsed(true);
                    },
                  ),
                ],
              ),
              const Spacer(
                flex: 1,
              ),
              NavigationDrawerItem(
                isCollapsed: isCollapsed,
                imagePath: 'assets/icons/reserve.png',
                title: 'reserve_label',
                onPressed: () {
                  controller.doctorPageIndex.value = 1;
                  controller.updateCollapsed(true);
                },
              ),
              const Spacer(
                flex: 1,
              ),
              NavigationDrawerExpandedItem(
                isCollapsed: isCollapsed,
                imagePath: 'assets/icons/patient.png',
                title: 'patient_label',
                onPressed: () {
                  isCollapsed ? controller.updateCollapsed(false) : null;
                },
                children: [
                  DrawerTextButton(
                    text: 'new_patient_label',
                    onPressed: () {
                      controller.doctorPageIndex.value = 2;
                      controller.updateCollapsed(true);
                    },
                  ),
                  DrawerTextButton(
                    text: 'search_patient_label',
                    onPressed: () {
                      controller.doctorPageIndex.value = 3;
                      controller.updateCollapsed(true);
                    },
                  ),
                ],
              ),
              const Spacer(
                flex: 1,
              ),
              NavigationDrawerExpandedItem(
                isCollapsed: isCollapsed,
                imagePath: 'assets/icons/finance.png',
                title: 'finance_label',
                onPressed: () {
                  isCollapsed ? controller.updateCollapsed(false) : null;
                },
                children: [
                  DrawerTextButton(
                    text: 'daily_revenue_label',
                    onPressed: () {
                      controller.doctorPageIndex.value = 4;
                      controller.updateCollapsed(true);
                    },
                  ),
                  DrawerTextButton(
                    text: 'patient_finance_label',
                    onPressed: () {
                      controller.doctorPageIndex.value = 5;
                      controller.updateCollapsed(true);
                    },
                  ),
                  DrawerTextButton(
                    text: 'clinic_expenses_label',
                    onPressed: () {
                      controller.doctorPageIndex.value = 6;
                      controller.updateCollapsed(true);
                    },
                  ),
                ],
              ),
              const Spacer(
                flex: 3,
              ),
              NavigationDrawerItem(
                isCollapsed: isCollapsed,
                imagePath: 'assets/icons/logout.png',
                title: 'logout_label',
                onPressed: () {
                  authcontroller.signOut();
                },
              ),
              const SizedBox(
                height: HSizes.spaceBtwItems,
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      controller.updateCollapsed(!isCollapsed);
                    },
                    child: isCollapsed
                        ? const Icon(Icons.arrow_forward_ios)
                        : const Icon(Icons.arrow_back_ios),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}