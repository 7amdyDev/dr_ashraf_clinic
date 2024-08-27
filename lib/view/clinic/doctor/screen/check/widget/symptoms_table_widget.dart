import 'package:dr_ashraf_clinic/controller/consultation_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SymptomsTableWidget extends StatelessWidget {
  SymptomsTableWidget({
    super.key,
    required this.consultationId,
  });

  final int consultationId;
  final consultationController = Get.find<ConsultationController>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: consultationController.getConsultById(consultationId),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Container(
              constraints:
                  const BoxConstraints(maxWidth: HSizes.maxPageWidth / 4),
              decoration: BoxDecoration(
                  color: HColors.primaryBackground,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2)),
              child: Obx(() => Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(width: 2)),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(9),
                            ),
                            color: HColors.accent,
                          ),
                          child: const Text(
                            'Symptoms',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Temp. ${snapshot.data!.temperature ?? ''}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const VerticalDivider(
                              width: 2,
                              color: Colors.black,
                            ),
                            Text(
                              'B.P ${snapshot.data!.bloodPressure ?? ''}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                        height: 1,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: HelperFunctions.screenHeight() / 3.5 - 40,
                        child: ListView.separated(
                          separatorBuilder: (context, int index) =>
                              const Divider(
                            height: 1,
                          ),
                          itemCount: consultationController.symptomsList.length,
                          itemBuilder: (context, int index) {
                            return SizedBox(
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: HSizes.defaultSpace),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      child: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                      ),
                                      onTap: () {
                                        consultationController.deleteSymptoms(
                                            consultationController
                                                .symptomsList[index].id!);
                                      },
                                    ),
                                    TableDataCell(
                                        text: consultationController
                                            .symptomsList[index].description),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
