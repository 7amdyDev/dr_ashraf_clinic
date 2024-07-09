import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_column_label.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';

class PatientReservationTable extends StatelessWidget {
  const PatientReservationTable(
      {super.key, required this.searchResult, required this.show});

  final List<String> searchResult;
  final bool show;
  @override
  Widget build(BuildContext context) {
    return show
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
                    DataColumn(label: TableColumnLabel(text: 'date_label')),
                    DataColumn(
                        label: TableColumnLabel(text: 'service_type_label')),
                    DataColumn(label: TableColumnLabel(text: 'finance_label')),
                    DataColumn(label: TableColumnLabel(text: 'status_label')),
                  ],
                  source: _DataSource(data: searchResult),

                  rowsPerPage:
                      searchResult.length < 8 ? searchResult.length : 8,
                  // horizontalMargin: 60,
                  showEmptyRows: false,
                ),
              ),
            ))
        : const SizedBox();
  }
}

class _DataSource extends DataTableSource {
  final List<String> data;

  _DataSource({required this.data});
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    //  final item = data[index];
    return const DataRow(cells: [
      DataCell(TableDataCell(text: '1')),
      DataCell(TableDataCell(text: 'دعاء منذر محمد عبدالمجيد')),
      DataCell(TableDataCell(text: '02-07-2024')),
      DataCell(TableDataCell(text: 'كشف')),
      DataCell(TableDataCell(text: 'مدفوع')),
      DataCell(TableDataCell(text: 'مكتمل')),

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