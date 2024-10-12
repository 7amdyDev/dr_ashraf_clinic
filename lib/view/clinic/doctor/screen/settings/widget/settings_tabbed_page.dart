import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/settings/widget/clinic_settings_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/settings/widget/medicine_settings_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/settings/widget/user_change_password.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:flutter/material.dart';

class SettingsTabbedPage extends StatelessWidget {
  const SettingsTabbedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: HColors.secondary,
        appBar: AppBar(
          toolbarHeight: 0,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            labelColor: Colors.red[600],
            tabs: const [
              Tab(
                child: PageLabelWidget(
                  text: 'medicines_label',
                  fontSize: 22,
                ),
              ),
              Tab(
                child: PageLabelWidget(
                  text: 'service_fees_label',
                  fontSize: 22,
                ),
              ),
              Tab(
                child: PageLabelWidget(
                  text: 'change_password',
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MedicineSettingsWidget(),
            const ClinicSettingsWidget(),
            const UserChangePassword()
          ],
        ),
      ),
    );
  }
}
