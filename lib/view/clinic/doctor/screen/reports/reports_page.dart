import 'package:dr_ashraf_clinic/controller/reports_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/reports/widget/reports_tabbed_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportsPage extends StatelessWidget {
  ReportsPage({super.key});
  final reportsController = Get.find<ReportsController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: HSizes.spaceBtwSections,
        ),
        const PageLabelWidget(
          text: 'reports_label',
        ),
        const SizedBox(
          height: HSizes.spaceBtwSections,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: HSizes.spaceBtwItems,
              ),
              SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.7,
                  child: const ReportsTabbedPage()),
            ],
          ),
        ),
      ],
    );
  }
}
