import 'package:dr_ashraf_clinic/controller/consultation_controller.dart';
import 'package:dr_ashraf_clinic/model/consultation_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExaminationTableWidget extends StatelessWidget {
  ExaminationTableWidget({
    super.key,
    required this.examainationList,
    this.previousCheck = false,
    required this.width,
  });

  final List<ExaminationsResultModel> examainationList;
  final bool previousCheck;
  final consultationController = Get.find<ConsultationController>();
  final double width;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
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
                    'examinations_label'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  )),
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: HelperFunctions.screenHeight() / 4,
                    minHeight: 40),
                child: ListView.separated(
                  separatorBuilder: (context, int index) => const Divider(
                    height: 1,
                  ),
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: examainationList.length,
                  itemBuilder: (context, int index) {
                    return SizedBox(
                      height: 40,
                      child: Padding(
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
                                      consultationController.deleteExamination(
                                          examainationList[index].id!);
                                    },
                                  )
                                : Container(),
                            Expanded(
                              child: TableDataCell(
                                  text:
                                      '${examainationList[index].name} :    ${examainationList[index].result ?? ''}'),
                            ),
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
  }
}
