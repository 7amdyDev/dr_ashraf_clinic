import 'package:dr_ashraf_clinic/controller/consultation_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrescriptionTableWidget extends StatelessWidget {
  PrescriptionTableWidget({
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
                            'Prescription',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: HelperFunctions.screenHeight() / 3.5,
                        child: ListView.separated(
                          separatorBuilder: (context, int index) =>
                              const Divider(
                            height: 1,
                          ),
                          itemCount:
                              consultationController.prescriptionList.length,
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
                                        consultationController
                                            .deletePrescription(
                                                consultationController
                                                    .prescriptionList[index]
                                                    .id!);
                                      },
                                    ),
                                    TableDataCell(
                                        text: consultationController
                                            .prescriptionList[index].medicine),
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
