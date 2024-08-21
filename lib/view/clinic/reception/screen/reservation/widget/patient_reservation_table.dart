import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/model/appointment_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_column_label.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientReservationTable extends StatelessWidget {
  const PatientReservationTable({
    super.key,
    required this.searchResult,
  });
  final List<AppointmentModel> searchResult;
  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: PaginatedDataTable(
              headingRowHeight: 48,
              horizontalMargin: 12,
              headingRowColor: const WidgetStatePropertyAll(HColors.accent),
              columnSpacing: 12,
              columns: const [
                DataColumn(label: TableColumnLabel(text: '#')),
                DataColumn(label: TableColumnLabel(text: 'patient_name_label')),
                DataColumn(label: TableColumnLabel(text: 'date_label')),
                DataColumn(label: TableColumnLabel(text: 'service_type_label')),
                DataColumn(label: TableColumnLabel(text: 'status_label')),
              ],
              source: _DataSource(data: searchResult),
              rowsPerPage: searchResult.isEmpty
                  ? 1
                  : searchResult.length < 8
                      ? searchResult.length
                      : 8,
              showEmptyRows: false,
            ),
          ),
        ));
  }
}

class _DataSource extends DataTableSource {
  final List<AppointmentModel> data;
  var controller = Get.put(PatientController());
  var financeController = Get.put(FinanceController());
  _DataSource({required this.data});

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];
    return DataRow(cells: [
      DataCell(TableDataCell(text: '${index + 1}')),
      DataCell(FutureBuilder(
          future: controller.getPatient(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return TableDataCell(text: snapshot.data!.name);
            } else {
              return const CircularProgressIndicator();
            }
          })),
      DataCell(TableDataCell(text: HFormatter.formatStringDate(item.date))),
      DataCell(TableDataCell(
          text: HValidator.serviceIdValidation(item.serviceId).tr)),
      DataCell(
          TableDataCell(text: HValidator.statusIdValidation(item.statusId).tr)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
