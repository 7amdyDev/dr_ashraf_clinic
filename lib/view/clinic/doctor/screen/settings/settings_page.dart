import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/settings/widget/settings_tabbed_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: HSizes.spaceBtwItems,
        ),
        PageLabelWidget(
          text: 'settings_label',
        ),
        SizedBox(
          height: HSizes.spaceBtwSections,
        ),
        Expanded(
          child: SettingsTabbedPage(),
        ),
      ],
    );
  }
}
