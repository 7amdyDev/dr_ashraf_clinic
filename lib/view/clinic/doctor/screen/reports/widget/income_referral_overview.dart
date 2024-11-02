import 'package:dr_ashraf_clinic/controller/reports_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/label_text_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/pick_date_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomeReferralOverview extends StatefulWidget {
  const IncomeReferralOverview({
    super.key,
  });

  @override
  State<IncomeReferralOverview> createState() => _IncomeReferralOverviewState();
}

class _IncomeReferralOverviewState extends State<IncomeReferralOverview> {
  final reportsController = Get.find<ReportsController>();

  int touchedIndex = -1;
  late List<Color> colorsList;
  List<String> titleList = [];
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  @override
  void initState() {
    if (reportsController.incomeReferralByDate.isNotEmpty) {
      colorsList = HelperFunctions.generateBarColors(
          reportsController.incomeReferralByDate.length);
      for (var item in reportsController.incomeReferralByDate) {
        if (item.referral!.isEmpty) {
          titleList.add('clinic_button'.tr);
        } else {
          titleList.add(item.referral!);
        }
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      child: SizedBox(
        // width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(HSizes.spaceBtwItems),
            child: Column(children: [
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
                        String toDate =
                            HFormatter.reverseFormatDate(toDateController.text);
                        reportsController
                            .getIncomeReferralByDate(fromDate, toDate)
                            .then((_) {
                          colorsList = HelperFunctions.generateBarColors(
                              reportsController.incomeReferralByDate.length);
                          for (var item
                              in reportsController.incomeReferralByDate) {
                            if (item.referral!.isEmpty) {
                              titleList.add('clinic_button'.tr);
                            } else {
                              titleList.add(item.referral!);
                            }
                          }
                        });
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
                  Obx(
                    () => reportsController.incomeReferralByDate.isNotEmpty
                        ? SizedBox(
                            width: HelperFunctions.clinicPagesWidth() * 0.45,
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
                                                      .incomeReferralByDate
                                                      .length) {
                                            return SideTitleWidget(
                                              axisSide: meta.axisSide,
                                              child: Text(titleList[index]),
                                            );
                                          }
                                          return const Text('');
                                        },
                                      ),
                                    ),
                                  ),
                                  barGroups: _createBarGroups(colorsList)),
                            ))
                        : SizedBox(),
                  ),
                  Obx(
                    () => reportsController.incomeReferralByDate.isNotEmpty
                        ? Column(
                            children: [
                              LabelTextWidget(
                                text: 'number_of_patient_label'.tr,
                                fontSizeAr: 20,
                                fontSizeEn: 18,
                              ),
                              SizedBox(
                                width: HelperFunctions.clinicPagesWidth() * 0.2,
                                height: MediaQuery.sizeOf(context).height * 0.3,
                                child: PieChart(
                                  PieChartData(
                                    sections: _createPieSections(colorsList),
                                    sectionsSpace: 0,
                                    pieTouchData: PieTouchData(
                                      touchCallback: (FlTouchEvent event,
                                          pieTouchResponse) {
                                        setState(() {
                                          if (!event
                                                  .isInterestedForInteractions ||
                                              pieTouchResponse == null ||
                                              pieTouchResponse.touchedSection ==
                                                  null) {
                                            touchedIndex = -1;
                                            return;
                                          }
                                          touchedIndex = pieTouchResponse
                                              .touchedSection!
                                              .touchedSectionIndex;
                                        });
                                      },
                                    ),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    centerSpaceRadius: 40,
                                  ),
                                ),
                              ),
                              if (touchedIndex != -1)
                                LabelTextWidget(
                                  text: titleList[touchedIndex],
                                ),
                            ],
                          )
                        : SizedBox(),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  double maxValue() {
    int value = 0;
    for (var amount in reportsController.incomeReferralByDate) {
      if (amount.totalIncome > value) {
        value = amount.totalIncome;
      }
    }
    return (value * 1.1 / 1000).ceil() * 1000;
  }

  List<PieChartSectionData> _createPieSections(List<Color> color) {
    List<PieChartSectionData> sections = [];
    var list = reportsController.incomeReferralByDate;

    for (int i = 0; i < list.length; i++) {
      final isTouched = i == touchedIndex;
      final radius = isTouched ? 60.0 : 50.0;

      sections.add(PieChartSectionData(
        value: list[i].count.toDouble(),
        color: color[i],
        radius: radius,
        titlePositionPercentageOffset: 1.2,
      ));
    }
    return sections;
  }

  List<BarChartGroupData> _createBarGroups(List<Color> color) {
    List<BarChartGroupData> barGroups = [];
    var list = reportsController.incomeReferralByDate;
    for (int i = 0; i < list.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i, // Index for the bar group
          barRods: [
            BarChartRodData(
              toY: list[i].totalIncome.toDouble(), // Value for the bar
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
