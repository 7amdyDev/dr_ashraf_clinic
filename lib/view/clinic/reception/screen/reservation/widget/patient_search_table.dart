import 'package:dr_ashraf_clinic/controller/appointment_controller.dart';
import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/model/patient_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_column_label.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientSearchTable extends StatelessWidget {
  const PatientSearchTable({super.key, required this.searchResult});

  final List<PatientModel> searchResult;

  @override
  Widget build(BuildContext context) {
    return searchResult.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(HSizes.defaultSpace),
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: PaginatedDataTable(
                  headingRowHeight: 48,
                  horizontalMargin: 12,
                  headingRowColor: const WidgetStatePropertyAll(HColors.accent),
                  columnSpacing: 12,
                  columns: const [
                    DataColumn(label: TableColumnLabel(text: 'id_no_label')),
                    DataColumn(
                        label: TableColumnLabel(text: 'patient_name_label')),
                    DataColumn(
                        label: TableColumnLabel(text: 'telephone_label')),
                    DataColumn(label: TableColumnLabel(text: 'age_label')),
                    DataColumn(label: TableColumnLabel(text: 'address_label')),
                  ],
                  source: _DataSource(data: searchResult),

                  rowsPerPage: searchResult.isEmpty
                      ? 1
                      : searchResult.length < 8
                          ? searchResult.length
                          : 8,
                  // horizontalMargin: 60,
                  showEmptyRows: false,
                ),
              ),
            ))
        : const SizedBox();
  }
}

class _DataSource extends DataTableSource {
  final List<PatientModel> data;
  final controller = Get.put(PatientController());
  final finaceController = Get.put(FinanceController());
  final appointmentController = AppointmentController();
  _DataSource({required this.data});
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    //  final item = data[index];
    return DataRow(cells: [
      DataCell(TableDataCell(text: data[index].id.toString())),
      DataCell(
        TableDataCell(text: data[index].name),
        onTap: () {
          controller.choosePatient(data[index].id!);
          finaceController.patientId.value = data[index].id!;
          finaceController.getPatientAccountslst();
          appointmentController.getPatientAppointment(data[index].id!);
          Get.back();
        },
      ),
      DataCell(TableDataCell(text: data[index].mobile)),
      DataCell(TableDataCell(text: data[index].age.toString())),
      DataCell(TableDataCell(text: data[index].address)),
      // const DataCell(Center(
      //     child:
      //         FittedBox(fit: BoxFit.scaleDown, child: CustomDropDownWidget()))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
