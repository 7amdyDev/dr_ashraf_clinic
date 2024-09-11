import 'package:dr_ashraf_clinic/model/patient_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_column_label.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientInfoTable extends StatelessWidget {
  const PatientInfoTable({
    super.key,
    required this.patientModel,
  });
  final PatientModel patientModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: DataTable(
          dataRowMinHeight: 32,
          dataRowMaxHeight: 32,
          border: TableBorder.all(
            borderRadius: BorderRadius.circular(5),
          ),
          headingRowHeight: 32,
          horizontalMargin: 12,
          headingRowColor: const WidgetStatePropertyAll(HColors.accent),
          columnSpacing: 12,
          columns: [
            DataColumn(label: TableColumnLabel(text: 'id_no_label'.tr)),
            DataColumn(label: TableColumnLabel(text: 'patient_name_label'.tr)),
            DataColumn(label: TableColumnLabel(text: 'age_label'.tr)),
            DataColumn(label: TableColumnLabel(text: 'gender_label'.tr)),
            DataColumn(label: TableColumnLabel(text: 'address_label'.tr)),
          ],
          rows: [
            DataRow(
              color: const WidgetStatePropertyAll(HColors.primaryBackground),
              cells: [
                DataCell(TableDataCell(text: '${patientModel.id}')),
                DataCell(TableDataCell(text: patientModel.name)),
                DataCell(TableDataCell(text: patientModel.age.toString())),
                DataCell(
                  TableDataCell(
                      text: HValidator.genderIdValidation(patientModel.gender)
                          .tr),
                ),
                DataCell(TableDataCell(text: patientModel.address)),
              ],
            ),
          ],
        ));
  }
}
