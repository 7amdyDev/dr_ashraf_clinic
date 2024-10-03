import 'dart:async';
import 'package:dr_ashraf_clinic/controller/consultation_controller.dart';
import 'package:dr_ashraf_clinic/model/consultation_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
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
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              DoctorTextAddWidget(
                textFontSize: 16,
                onChanged: _onSearchChanged,
                textEditingController: prescriptionEditingController,
                label: 'medicine_label'.tr,
                onPressed: () {
                  if (prescriptionEditingController.text.isNotEmpty) {
                    PrescriptionModel record = PrescriptionModel(
                        consultationId: consultationController.consultId.value,
                        medicine: prescriptionEditingController.text);
                    consultationController.addPrescription(record);
                    prescriptionEditingController.clear();
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: 100,
            child: _buildResultsList(),
          )
        ],
      ),
    );
  }

  void _onSearchChanged(String query) {
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
          return Card(
            elevation: 4,
            child: ListTile(
              title: Text(
                result[index].name,
                textAlign: TextAlign.center,
              ),
              onTap: () {
                prescriptionEditingController.text = result[index].name;
                clinicController.dbMedicineSearch.clear();
                _searchQuery = '';
              },
            ),
          );
        },
      ),
    );
  }
}
