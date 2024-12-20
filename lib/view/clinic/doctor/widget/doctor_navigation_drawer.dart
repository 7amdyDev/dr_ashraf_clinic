import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/clinic_branch_name.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/navigation_drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HDoctorNavigationDrawer extends StatelessWidget {
  const HDoctorNavigationDrawer({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClinicController>();
    final size = HelperFunctions.screenSize();

    return SizedBox(
      width: HelperFunctions.drawerWidth(),
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
              Container(
                color: HColors.primaryBackground,
                child: ClinicBranchName(),
              ),
              const Divider(),
              const SizedBox(
                height: HSizes.spaceBtwItems,
              ),
              Expanded(
                child: ListView(
                  children: [
                    NavigationDrawerItem(
                        imagePath: 'assets/icons/calender2.png',
                        title: 'appointment_label',
                        pageIndex: 0,
                        onPressed: () {
                          controller.pageIndex.value = 0;
                        }),
                    const SizedBox(
                      height: HSizes.spaceBtwItems,
                    ),
                    NavigationDrawerItem(
                      imagePath: 'assets/icons/reserve2.png',
                      title: 'reserve_label',
                      pageIndex: 1,
                      onPressed: () {
                        controller.pageIndex.value = 1;
                      },
                    ),
                    const SizedBox(
                      height: HSizes.spaceBtwItems,
                    ),
                    NavigationDrawerItem(
                      imagePath: 'assets/icons/new_patient.png',
                      title: 'new_patient_label',
                      pageIndex: 2,
                      onPressed: () {
                        controller.pageIndex.value = 2;
                      },
                    ),
                    const SizedBox(
                      height: HSizes.spaceBtwItems,
                    ),
                    NavigationDrawerItem(
                      imagePath: 'assets/icons/patient_search2.png',
                      title: 'search_patient_label',
                      pageIndex: 3,
                      onPressed: () {
                        controller.pageIndex.value = 3;
                      },
                    ),
                    const SizedBox(
                      height: HSizes.spaceBtwItems,
                    ),
                    NavigationDrawerItem(
                      imagePath: 'assets/icons/daily_income.png',
                      title: 'daily_revenue_label',
                      pageIndex: 4,
                      onPressed: () {
                        controller.pageIndex.value = 4;
                      },
                    ),
                    const SizedBox(
                      height: HSizes.spaceBtwItems,
                    ),
                    NavigationDrawerItem(
                      imagePath: 'assets/icons/patient_finance.png',
                      title: 'patient_finance_label',
                      pageIndex: 5,
                      onPressed: () {
                        controller.pageIndex.value = 5;
                      },
                    ),
                    const SizedBox(
                      height: HSizes.spaceBtwItems,
                    ),
                    NavigationDrawerItem(
                      imagePath: 'assets/icons/finance.png',
                      title: 'clinic_expenses_label',
                      pageIndex: 6,
                      onPressed: () {
                        controller.pageIndex.value = 6;
                      },
                    ),
                    const SizedBox(
                      height: HSizes.spaceBtwItems,
                    ),
                    NavigationDrawerItem(
                      imagePath: 'assets/icons/report.png',
                      title: 'reports_label',
                      pageIndex: 8,
                      onPressed: () {
                        controller.pageIndex.value = 8;
                      },
                    ),
                    const SizedBox(
                      height: HSizes.spaceBtwItems,
                    ),
                    NavigationDrawerItem(
                      imagePath: 'assets/icons/setting.png',
                      title: 'settings_label',
                      pageIndex: 9,
                      onPressed: () {
                        controller.pageIndex.value = 9;
                      },
                    ),
                    const SizedBox(
                      height: HSizes.spaceBtwItems,
                    ),
                    // const Spacer(
                    //   flex: 3,
                    // ),
                    // NavigationDrawerItem(
                    //   imagePath: 'assets/icons/logout.png',
                    //   title: 'logout_label',
                    //   pageIndex: 10,
                    //   onPressed: () {
                    //     authcontroller.signOut();
                    //   },
                    // ),
                    const SizedBox(
                      height: HSizes.spaceBtwItems,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
