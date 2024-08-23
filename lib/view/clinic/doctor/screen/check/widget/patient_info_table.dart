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
  final List<PatientModel> patientModel;
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
                DataCell(TableDataCell(text: '${patientModel[0].id}')),
                DataCell(TableDataCell(text: patientModel[0].name)),
                DataCell(TableDataCell(text: patientModel[0].age.toString())),
                DataCell(
                  TableDataCell(
                      text:
                          HValidator.genderIdValidation(patientModel[0].gender)
                              .tr),
                ),
                DataCell(TableDataCell(text: patientModel[0].address)),
              ],
            ),
          ],
        ));
  }
}

// class _DataSource extends DataTableSource {
//   final List<PatientModel> data;
//   _DataSource({required this.data});

//   @override
//   DataRow? getRow(int index) {
//     if (index >= data.length) {
//       return null;
//     }

//     final item = data[index];
//     return DataRow(cells: [
//       DataCell(TableDataCell(text: '${item.id}')),
//       DataCell(TableDataCell(text: item.name)),
//       DataCell(TableDataCell(text: item.age.toString())),
//       DataCell(
//         TableDataCell(text: item.gender.toString()),
//       ),
//       DataCell(TableDataCell(text: item.address)),
//     ]);
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => data.length;

//   @override
//   int get selectedRowCount => 0;
// }
