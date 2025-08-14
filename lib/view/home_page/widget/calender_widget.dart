// calendar_screen.dart
import 'package:dr_ashraf_clinic/controller/calender_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/label_text_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/page_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key, required this.isDesktopView});

  final bool isDesktopView;

  @override
  Widget build(BuildContext context) {
    // Inject the controller
    final controller = Get.put(CalendarController());
    final size = MediaQuery.sizeOf(context);

    return Container(
      constraints: BoxConstraints(maxWidth: HelperFunctions.clinicPagesWidth()),

      child: SizedBox(
        width: isDesktopView ? size.width / 2 : size.width * 0.9,
        child: Column(
          children: [
            const PageTitleWidget(text: 'book_sheet_label'),
            const SizedBox(height: HSizes.spaceBtwSections),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: Colors.indigo,
                      size: 36,
                    ),
                    const SizedBox(width: 8),
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat(
                              'MMMM yyyy',
                            ).format(controller.currentDate.value),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed:
                            controller.currentDate.value.year <
                                    DateTime.now().year ||
                                (controller.currentDate.value.year ==
                                        DateTime.now().year &&
                                    controller.currentDate.value.month <=
                                        DateTime.now().month)
                            ? null
                            : controller.previousMonth,
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed:
                            controller.currentDate.value.isAfter(
                              DateTime(
                                DateTime.now().year,
                                DateTime.now().month + 2,
                              ),
                            )
                            ? null
                            : controller.nextMonth,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: isDesktopView ? size.width / 2 : size.width * 0.9,

              child: Column(
                children: [
                  GridView.count(
                    crossAxisCount: 7,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                        .map(
                          (day) => Center(
                            child: Text(
                              day,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: HColors.dark,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: isDesktopView ? size.width / 2 : size.width * 0.9,
                    height: isDesktopView ? size.width / 2.2 : size.width * 0.8,
                    child: Obx(
                      () => GridView.count(
                        crossAxisCount: 7,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        children: controller.buildCalendarDays(context),
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LabelTextWidget(
                                text: 'clinic_branch_label',
                                fontSizeAr: 18,
                              ),
                              SizedBox(height: HSizes.spaceBtwSections),
                              LabelTextWidget(
                                text: 'name_label',
                                fontSizeAr: 18,
                              ),
                              SizedBox(height: HSizes.spaceBtwSections),
                              LabelTextWidget(
                                text: 'mobile_label',
                                fontSizeAr: 18,
                              ),
                              SizedBox(height: HSizes.spaceBtwSections),
                            ],
                          ),
                        ),

                        Column(
                          children: [
                            Obx(
                              () => SizedBox(
                                width: (size.width / 2).clamp(150, 300),
                                child: DropdownButtonFormField<String>(
                                  value: controller.selectedClinic.value,
                                  decoration: InputDecoration(
                                    labelText: 'clinic_branch_label'.tr,
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                    ),
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      value: '1',
                                      child: FittedBox(
                                        child: Text('عيادة سموحة'.tr),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: '2',
                                      child: FittedBox(
                                        child: Text('عيادة العجمي'.tr),
                                      ),
                                    ),
                                  ],
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      controller.selectedClinic.value =
                                          newValue;
                                      controller.fetchReservations();
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: HSizes.spaceBtwItems),
                            SizedBox(
                              width: (size.width / 2).clamp(150, 300),
                              child: Form(
                                key: controller.nameKey,
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.disabled,
                                  validator: HValidator.validateText,
                                  textAlign: TextAlign.center,
                                  controller: controller.nameController,
                                ),
                              ),
                            ),
                            const SizedBox(height: HSizes.spaceBtwItems),
                            SizedBox(
                              width: (size.width / 2).clamp(150, 300),
                              child: Form(
                                key: controller.mobileKey,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  validator: HValidator.validateText,
                                  controller: controller.mobileController,
                                ),
                              ),
                            ),
                            const SizedBox(height: HSizes.spaceBtwSections),
                          ],
                        ),
                        const SizedBox(width: HSizes.spaceBtwSections),
                      ],
                    ),
                  ),
                  HFilledButton(
                    text: 'reserve_label'.tr,
                    onPressed: controller.submitReservation,
                  ),
                ],
              ),
            ),
            // const SizedBox(height: HSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
