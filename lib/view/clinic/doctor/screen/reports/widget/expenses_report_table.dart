import 'package:dr_ashraf_clinic/controller/reports_controller.dart';
import 'package:dr_ashraf_clinic/model/expense_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_column_label.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensesReportTable extends StatelessWidget {
  ExpensesReportTable({super.key});

  final reportsController = Get.find<ReportsController>();
  @override
  Widget build(BuildContext context) {
    var searchResult = reportsController.expenseRecordsByDate;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: HelperFunctions.clinicPagesWidth() * 0.4,
            child: PaginatedDataTable(
              headingRowHeight: 48,
              horizontalMargin: 12,
              headingRowColor: const WidgetStatePropertyAll(HColors.accent),
              columnSpacing: 12,
              columns: const [
                DataColumn(label: TableColumnLabel(text: '#')),
                DataColumn(label: TableColumnLabel(text: 'description_label')),
                DataColumn(label: TableColumnLabel(text: 'date_label')),
                DataColumn(label: TableColumnLabel(text: 'expense_type_label')),
                DataColumn(label: TableColumnLabel(text: 'value_label')),
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
        ],
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<ExpenseModel> data;

  _DataSource({required this.data});

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];

    return DataRow(cells: [
      DataCell(TableDataCell(text: (index + 1).toString())),
      DataCell(TableDataCell(text: item.description)),
      DataCell(TableDataCell(text: HFormatter.formatStringDate(item.date))),
      DataCell(TableDataCell(
          text: HValidator.expenseCodeValidation((item.accountId)).tr)),
      DataCell(TableDataCell(text: item.value.toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
