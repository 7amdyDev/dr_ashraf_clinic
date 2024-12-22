import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/reports/widget/expense_overview.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/reports/widget/income_expense_overview.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/reports/widget/income_referral_overview.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:flutter/material.dart';

class ReportsTabbedPage extends StatelessWidget {
  const ReportsTabbedPage({super.key});

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
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: PageLabelWidget(
                        fontSize: 22,
                        text: 'income_expense_label',
                      ),
                    ),
                  ),
                  Tab(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: PageLabelWidget(
                        fontSize: 22,
                        text: 'income_report_label',
                      ),
                    ),
                  ),
                  Tab(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: PageLabelWidget(
                        fontSize: 22,
                        text: 'expense_report_label',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                IncomeExpenseOverview(),
                IncomeReferralOverview(),
                ExpenseOverview()
              ],
            )));
  }
}
