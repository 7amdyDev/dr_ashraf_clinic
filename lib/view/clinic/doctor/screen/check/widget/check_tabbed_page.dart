import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/new_check_page.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/previous_check.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:flutter/material.dart';

class CheckTabbedPage extends StatelessWidget {
  const CheckTabbedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: HColors.secondary,
            appBar: AppBar(
              toolbarHeight: 0,
              automaticallyImplyLeading: false,
              bottom: const TabBar(
                tabs: [
                  Tab(
                    child: PageLabelWidget(
                      fontSize: 24,
                      text: 'new_check_label',
                    ),
                  ),
                  Tab(
                    child: PageLabelWidget(
                      fontSize: 24,
                      text: 'previous_check_label',
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                NewCheckPage(),
                PreviousCheck(),
              ],
            )));
  }
}
