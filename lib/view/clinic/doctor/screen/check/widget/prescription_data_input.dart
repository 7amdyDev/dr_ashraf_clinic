import 'dart:async';
import 'package:dr_ashraf_clinic/controller/consultation_controller.dart';
import 'package:dr_ashraf_clinic/model/consultation_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/doctor_text_add.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/drop_down_menu.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/label_text_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrescriptionDataInput extends StatefulWidget {
  const PrescriptionDataInput({
    super.key,
    required this.width,
  });
  final double width;

  @override
  State<PrescriptionDataInput> createState() => _PrescriptionDataInputState();
}

final database = FirebaseDatabase.instance;

class _PrescriptionDataInputState extends State<PrescriptionDataInput> {
  final consultationController = Get.find<ConsultationController>();
  String _searchQuery = '';
  Timer? _debounce;
  TextEditingController prescriptionEditingController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  bool show = false;
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
          LabelTextWidget(text: 'prescription_label'.tr),
          DoctorTextAddWidget(
            textFontSize: 16,
            onChanged: _onSearchChanged,
            textEditingController: prescriptionEditingController,
            label: 'medicine_label'.tr,
            onPressed: () {
              if (prescriptionEditingController.text.isNotEmpty) {
                PrescriptionModel record = PrescriptionModel(
                  consultationId: consultationController.consultId.value,
                  medicine: prescriptionEditingController.text,
                  dosage: dosageController.text,
                );
                clinicController.saveDosageToDB(dosageController.text);
                consultationController.addPrescription(record);
                prescriptionEditingController.clear();
                dosageController.clear();

                setState(() {
                  show = false;
                });
              }
            },
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 100,
                child: _buildResultsList(),
              ),
              show
                  ? Autocomplete<String>(
                      optionsBuilder: (TextEditingValue fruitTextEditingValue) {
                        // if user is input nothing
                        if (fruitTextEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }

                        // if user is input something the build
                        // suggestion based on the user input
                        return clinicController.dosageSuggestion
                            .where((String option) {
                          return option.contains(
                              fruitTextEditingValue.text.toLowerCase());
                        });
                      },
                      fieldViewBuilder: (context, textEditingController,
                          focusNode, onFieldSubmitted) {
                        return SizedBox(
                          width: 200,
                          child: TextField(
                            decoration: InputDecoration(
                                labelText: 'dosage_label'.tr,
                                labelStyle: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'NotoNaskh',
                                  fontWeight: FontWeight.bold,
                                )),
                            onChanged: (value) => dosageController.text = value,
                            onEditingComplete: onFieldSubmitted,
                            focusNode: focusNode,
                            controller: textEditingController,
                          ),
                        );
                      },
                      optionsViewBuilder: (context, onSelected, options) {
                        return Align(
                          alignment: HelperFunctions.isLocalEnglish()
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          child: SizedBox(
                            width: 200,
                            child: Card(
                              elevation: 4.0,
                              child: ListView(
                                children: options.map((String option) {
                                  return ListTile(
                                    title: Center(
                                      child: Text(
                                        option,
                                        style: const TextStyle(
                                          fontFamily: 'NotoNaskh',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      // Handle the selection of an option
                                      onSelected(option);
                                      dosageController.text = option;
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                      // when user click on the suggested
                      // item this function calls
                      // onSelected: (String value) {
                      //   debugPrint('You just selected $value');
                      //   notesController.text = value;
                      // },
                    )
                  : const SizedBox(
                      height: 105,
                    ),
            ],
          ),
        ],
      ),
    );
  }

  void _onSearchChanged(String query) {
    setState(() {
      show = false;
    });

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _searchQuery = query.toLowerCase();
      });
      clinicController.searchMedicineDatabase(_searchQuery);
    });
  }

  Widget _buildResultsList() {
    var result = clinicController.dbMedicineSearch;
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
              prescriptionEditingController.text = result[index].name;
              clinicController.dbMedicineSearch.clear();
              _searchQuery = '';
              setState(() {
                show = true;
              });
            },
          );
        },
      ),
    );
  }
}
