import 'package:dr_ashraf_clinic/controller/reports_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/reports/widget/expenses_report_table.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/label_text_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/pick_date_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseOverview extends StatelessWidget {
  ExpenseOverview({super.key});

  final reportsController = Get.find<ReportsController>();
  @override
  Widget build(BuildContext context) {
    TextEditingController fromDateController = TextEditingController();
    TextEditingController toDateController = TextEditingController();
    List<Color> colorsList = HelperFunctions.generateBarColors(
        reportsController.expenseOverviewByDate.length);
    return SingleChildScrollView(
      primary: true,
      child: SizedBox(
        // width: double.infinity,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: LabelTextWidget(
                            text: 'from_label'.tr,
                            fontSizeEn: 16,
                            fontSizeAr: 18,
                          ),
                        ),
                        PickDateWidget(
                            firstDate: DateTime(2024),
                            lastDate: DateTime.now().add(Duration(days: 1)),
                            width: 200,
                            dateController: fromDateController),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: LabelTextWidget(
                            text: 'to_label'.tr,
                            fontSizeEn: 16,
                            fontSizeAr: 18,
                          ),
                        ),
                        PickDateWidget(
                            firstDate: DateTime(2024),
                            lastDate: DateTime.now().add(Duration(days: 1)),
                            width: 200,
                            dateController: toDateController),
                      ],
                    ),
                    HFilledButton(
                      text: 'search_label'.tr,
                      fontSize: 22,
                      onPressed: () {
                        if (fromDateController.text.isNotEmpty &&
                            toDateController.text.isNotEmpty) {
                          String fromDate = HFormatter.reverseFormatDate(
                              fromDateController.text);
                          String toDate = HFormatter.reverseFormatDate(
                              toDateController.text);
                          reportsController
                              .getExpenseOverviewByDate(fromDate, toDate)
                              .then((_) {
                            colorsList = HelperFunctions.generateBarColors(
                                reportsController.expenseOverviewByDate.length);
                          });
                          reportsController.getExpenseQueryByDate(
                              fromDate, toDate);
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: HSizes.spaceBtwSections,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => reportsController.expenseOverviewByDate.isNotEmpty
                        ? SizedBox(
                            width: HelperFunctions.clinicPagesWidth() * 0.3,
                            height: MediaQuery.sizeOf(context).height * 0.45,
                            child: BarChart(
                              BarChartData(
                                  maxY: maxValue(),
                                  titlesData: FlTitlesData(
                                    topTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false)),
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
                                                      .expenseOverviewByDate
                                                      .length) {
                                            return SideTitleWidget(
                                              axisSide: meta.axisSide,
                                              child: Text(HValidator
                                                      .expenseCodeValidation(
                                                          reportsController
                                                              .expenseOverviewByDate[
                                                                  index]
                                                              .accountId)
                                                  .tr),
                                            );
                                          }
                                          return const Text('');
                                        },
                                      ),
                                    ),
                                  ),
                                  barGroups: _createBarGroups(colorsList)),
                            ),
                          )
                        : SizedBox()),
                    Obx(() => reportsController.expenseRecordsByDate.isNotEmpty
                        ? SizedBox(
                            width: HelperFunctions.clinicPagesWidth() * 0.4,
                            height: MediaQuery.sizeOf(context).height * 0.45,
                            child: ExpensesReportTable())
                        : SizedBox())
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double maxValue() {
    int value = 0;
    for (var amount in reportsController.expenseOverviewByDate) {
      if (amount.totalExpense > value) {
        value = amount.totalExpense;
      }
    }
    return (value * 1.1 / 1000).ceil() * 1000;
  }

  List<BarChartGroupData> _createBarGroups(List<Color> color) {
    List<BarChartGroupData> barGroups = [];
    var list = reportsController.expenseOverviewByDate;
    for (int i = 0; i < list.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i, // Index for the bar group
          barRods: [
            BarChartRodData(
              toY: list[i].totalExpense.toDouble(), // Value for the bar
              color: color[i],
              width: 18,
            ),
          ],
        ),
      );
    }

    return barGroups;
  }
}
