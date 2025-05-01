import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/controller/expense_controller.dart';
import 'package:dr_ashraf_clinic/model/expense_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_column_label.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensesTable extends StatefulWidget {
  const ExpensesTable({
    super.key,
  });

  @override
  State<ExpensesTable> createState() => _ExpensesTableState();
}

class _ExpensesTableState extends State<ExpensesTable> {
  int? expenseId;

  @override
  Widget build(BuildContext context) {
    final expenseController = Get.find<ExpenseController>();
    final clinicController = Get.find<ClinicController>();
    final List<ExpenseModel> searchResult = expenseController.expenseslst;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => PaginatedDataTable(
                headingRowHeight: 48,
                horizontalMargin: 12,
                headingRowColor: const WidgetStatePropertyAll(HColors.accent),
                columnSpacing: 12,
                columns: const [
                  DataColumn(label: TableColumnLabel(text: '#')),
                  DataColumn(
                      label: TableColumnLabel(text: 'description_label')),
                  DataColumn(label: TableColumnLabel(text: 'date_label')),
                  DataColumn(
                      label: TableColumnLabel(text: 'expense_type_label')),
                  DataColumn(label: TableColumnLabel(text: 'value_label')),
                ],
                source: _DataSource(data: searchResult, expenseId: expenseId,
                    (value) {
                  setState(() {
                    expenseId = value;
                  });
                }),
                rowsPerPage: searchResult.isEmpty
                    ? 1
                    : searchResult.length < 8
                        ? searchResult.length
                        : 8,
                showEmptyRows: false,
              ),
            ),
          ),
          const SizedBox(
            height: HSizes.spaceBtwItems,
          ),
          !clinicController.scheduleByDate.value
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    expenseId != null
                        ? HFilledButton(
                            text: 'delete_button',
                            fontSize: 22,
                            onPressed: () {
                              expenseController.removeExpense(expenseId!);
                              setState(() {
                                expenseId = null;
                              });
                            },
                          )
                        : const SizedBox(),
                  ],
                )
              : const SizedBox(),
          const SizedBox(
            height: HSizes.spaceBtwItems,
          )
        ],
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<ExpenseModel> data;
  final Function(int) onSelected;
  final int? expenseId;
  _DataSource(this.onSelected, {required this.expenseId, required this.data});

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];

    return DataRow(
        selected: expenseId == item.id,
        color: expenseId == item.id
            ? const WidgetStatePropertyAll<Color>(Colors.black12)
            : null,
        cells: [
          DataCell(TableDataCell(text: (index + 1).toString())),
          DataCell(
            TableDataCell(text: item.description),
            onTap: () {
              onSelected(item.id!);
            },
          ),
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
