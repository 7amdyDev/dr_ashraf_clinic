import 'package:dr_ashraf_clinic/controller/consultation_controller.dart';
import 'package:dr_ashraf_clinic/model/consultation_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrescriptionTableWidget extends StatelessWidget {
  PrescriptionTableWidget({
    required this.prescriptionList,
    this.previousCheck = false,
    super.key,
    required this.width,
  });
  final List<PrescriptionModel> prescriptionList;
  final bool previousCheck;
  final consultationController = Get.find<ConsultationController>();
  final double width;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          constraints: BoxConstraints(maxWidth: width),
          decoration: BoxDecoration(
              color: HColors.primaryBackground,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 5,
                  color: Colors.black54,
                )
              ],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2)),
          child: Column(
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
                  child: Text(
                    'prescription_label'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  )),
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: previousCheck
                        ? HelperFunctions.screenHeight() * 0.7
                        : HelperFunctions.screenHeight() / 4,
                    minHeight: 40),
                child: ListView.separated(
                  separatorBuilder: (context, int index) => const Divider(
                    height: 1,
                  ),
                  shrinkWrap: true,
                  itemCount: prescriptionList.length,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: HSizes.defaultSpace),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          !previousCheck
                              ? InkWell(
                                  child: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                  onTap: () {
                                    consultationController.deletePrescription(
                                        prescriptionList[index].id!);
                                  },
                                )
                              : Container(),
                          Expanded(
                            child: ListTile(
                              title: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  prescriptionList[index].medicine,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontFamily: 'NotoNaskh',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ),
                              subtitle:
                                  prescriptionList[index].dosage!.isNotEmpty
                                      ? Text(
                                          prescriptionList[index].dosage ?? '',
                                          //  textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontFamily: 'NotoNaskh',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        )
                                      : null,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
