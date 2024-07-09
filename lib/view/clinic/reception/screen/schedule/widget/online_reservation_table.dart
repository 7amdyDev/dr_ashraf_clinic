import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_column_label.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/checkbox_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HOnlineReservationTable extends StatelessWidget {
  const HOnlineReservationTable({
    super.key,
    required this.searchResult,
  });

  final List<String> searchResult;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              DataColumn(label: TableColumnLabel(text: ' # ')),
              DataColumn(label: TableColumnLabel(text: 'patient_name_label')),
              DataColumn(label: TableColumnLabel(text: 'date_label')),
              DataColumn(label: TableColumnLabel(text: 'service_type_label')),
              DataColumn(label: TableColumnLabel(text: 'telephone_label')),
              DataColumn(
                  label: TableColumnLabel(text: 'request_checkbox_label')),
            ],
            source: _DataSource(data: searchResult),

            rowsPerPage: searchResult.length < 8 ? searchResult.length : 8,
            // horizontalMargin: 60,
            showEmptyRows: false,
          ),
        ),
      ),
    );
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
    return DataRow(cells: [
      const DataCell(TableDataCell(text: '1')),
      const DataCell(TableDataCell(text: 'دعاء منذر محمد عبدالمجيد')),
      DataCell(TableDataCell(
          text: DateFormat('dd-MM-yyyy').format(DateTime.now()).toString())),
      const DataCell(TableDataCell(text: 'كشف')),
      const DataCell(TableDataCell(text: '01008169644')),
      const DataCell(Center(child: TableCheckBoxWidget()))
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
