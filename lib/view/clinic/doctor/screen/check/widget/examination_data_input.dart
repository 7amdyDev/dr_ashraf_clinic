import 'dart:async';
import 'package:dr_ashraf_clinic/controller/consultation_controller.dart';
import 'package:dr_ashraf_clinic/model/consultation_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/drop_down_menu.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/label_text_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExaminationDataInput extends StatefulWidget {
  const ExaminationDataInput({
    super.key,
    required this.width,
  });
  final double width;

  @override
  State<ExaminationDataInput> createState() => _ExaminationDataInputState();
}

final database = FirebaseDatabase.instance;

class _ExaminationDataInputState extends State<ExaminationDataInput> {
  final consultationController = Get.find<ConsultationController>();
  String _searchQuery = '';
  Timer? _debounce;
  TextEditingController examinationEditingController = TextEditingController();
  TextEditingController resultController = TextEditingController();
  bool show = false;

  // Define FocusNodes for the TextFields
  final FocusNode examinationFocusNode = FocusNode();
  final FocusNode resultFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: widget.width,
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          color: HColors.primaryBackground,
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              color: Colors.black,
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          LabelTextWidget(text: 'examinations_label'.tr),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'examination_label'.tr,
                        style: const TextStyle(
                          fontFamily: 'NotoNaskh',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: widget.width / 2.5,
                    height: 50,
                    child: TextField(
                        controller: examinationEditingController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(
                          fontSize: 18,
                          fontFamily: 'NotoNaskh',
                          fontWeight: FontWeight.bold,
                        )),
                        onChanged: _onSearchChanged,
                        focusNode:
                            examinationFocusNode, // Assign the focus node
                        textInputAction:
                            TextInputAction.next, // Move to the next field

                        onSubmitted: (_) {
                          clinicController.dbExaminationSearch.clear();
                          _searchQuery = '';
                          setState(() {
                            show = true;
                          });
                          // Move focus to the result field when the user submits
                          FocusScope.of(context).requestFocus(resultFocusNode);
                        }),
                  ),
                  Stack(alignment: Alignment.center, children: [
                    SizedBox(
                      height: 100,
                      width: widget.width / 2.5,
                      child: _buildResultsList(),
                    ),
                  ])
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'result_label'.tr,
                        style: const TextStyle(
                          fontFamily: 'NotoNaskh',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: widget.width / 2.5,
                    height: 150,
                    child: TextFormField(
                      controller: resultController,
                      decoration: InputDecoration(
                          prefixIcon: IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              color: HColors.primary,
                            ),
                            onPressed: () {
                              addExamination();
                            },
                          ),
                          labelStyle: TextStyle(
                            fontSize: 18,
                            fontFamily: 'NotoNaskh',
                            fontWeight: FontWeight.bold,
                          )),

                      // onChanged: (value) => resultController.text = value,
                      onFieldSubmitted: (value) => addExamination(),
                      focusNode: resultFocusNode,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void addExamination() {
    if (examinationEditingController.text.isNotEmpty &&
        resultController.text.isNotEmpty) {
      ExaminationsResultModel record = ExaminationsResultModel(
        consultationId: consultationController.consultId.value,
        name: examinationEditingController.text.toUpperCase(),
        result: resultController.text,
      );
      consultationController.addExamination(record);
      examinationEditingController.clear();
      resultController.clear();
      FocusScope.of(context).requestFocus(examinationFocusNode);
      setState(() {
        show = false;
      });
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _searchQuery = query.toLowerCase();
      });
      clinicController.searchExaminationDatabase(_searchQuery);
    });
  }

  Widget _buildResultsList() {
    var result = clinicController.dbExaminationSearch;
    return Obx(
      () => ListView.builder(
        itemCount: result.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              result[index].name,
              textAlign: TextAlign.center,
            ),
            onTap: () {
              examinationEditingController.text = result[index].name;
              clinicController.dbExaminationSearch.clear();
              _searchQuery = '';
              setState(() {
                show = true;
              });
              FocusScope.of(context).requestFocus(resultFocusNode);
            },
          );
        },
      ),
    );
  }
}
