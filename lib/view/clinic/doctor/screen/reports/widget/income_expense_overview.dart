import 'package:dr_ashraf_clinic/controller/reports_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/reports/widget/drop_down_period_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/reports/widget/dropdown_branches_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomeExpenseOverview extends StatelessWidget {
  IncomeExpenseOverview({super.key});
  final reportsController = Get.find<ReportsController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(HSizes.spaceBtwItems),
            child: Column(
              children: [
                SizedBox(
                  height: HSizes.spaceBtwItems,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: 200, child: DropdownPeriodWidget()),
                    SizedBox(width: 200, child: DropdownBranchWidget()),
                  ],
                ),
                const SizedBox(
                  height: HSizes.spaceBtwSections,
                ),
                SizedBox(
                  width: HelperFunctions.clinicPagesWidth() * 0.7,
                  height: MediaQuery.sizeOf(context).height * 0.45,
                  child: Obx(
                    () => BarChart(
                      BarChartData(
                          maxY: maxValue(),
                          titlesData: FlTitlesData(
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 32,
                                getTitlesWidget: (value, meta) {
                                  // Use the index to get the correct label
                                  int index = value.toInt();
                                  if (index >= 0 &&
                                      index <
                                          reportsController
                                              .incomeExpenseOverview.length) {
                                    return SideTitleWidget(
                                      meta: meta,
                                      // axisSide: meta.axisSide,
                                      child: Text(reportsController
                                          .incomeExpenseOverview[index].period),
                                    );
                                  }
                                  return const Text('');
                                },
                              ),
                            ),
                          ),
                          barGroups: _createBarGroups()),
                    ),
                  ),
                ),
                SizedBox(
                  height: HSizes.spaceBtwItems,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  double maxValue() {
    int value = 0;
    for (var amount in reportsController.incomeExpenseOverview) {
      if (amount.totalIncome! > value) {
        value = amount.totalIncome!;
      }
    }
    return (value * 1.1 / 1000).ceil() * 1000;
  }

  List<BarChartGroupData> _createBarGroups() {
    List<BarChartGroupData> barGroups = [];
    var list = reportsController.incomeExpenseOverview;
    for (int i = 0; i < list.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i, // Index for the bar group
          barRods: [
            BarChartRodData(
              toY: list[i].totalIncome!.toDouble(), // Value for the bar
              color: Colors.blue,
              width: 18,
            ),
            BarChartRodData(
              toY: list[i].totalExpense!.toDouble(), // Value for the bar
              color: Colors.orange,
              width: 18,
            ),
          ],
        ),
      );
    }

    return barGroups;
  }
}
