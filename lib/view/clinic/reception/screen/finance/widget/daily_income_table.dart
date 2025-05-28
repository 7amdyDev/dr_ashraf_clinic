import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/model/finance_models.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_column_label.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyIncomeTable extends StatelessWidget {
  DailyIncomeTable({super.key});
  final financeController = Get.put(FinanceController());

  @override
  Widget build(BuildContext context) {
    var assetData = financeController.assetDailyIncomelst;
    return Obx(
      () => SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: PaginatedDataTable(
            headingRowHeight: 48,
            horizontalMargin: 12,
            headingRowColor: const WidgetStatePropertyAll(HColors.accent),
            columnSpacing: 12,
            columns: const [
              DataColumn(label: TableColumnLabel(text: 'id_no_label')),
              DataColumn(label: TableColumnLabel(text: 'patient_name_label')),
              DataColumn(label: TableColumnLabel(text: 'date_label')),
              DataColumn(label: TableColumnLabel(text: 'service_type_label')),
              DataColumn(label: TableColumnLabel(text: 'patient_paid_label')),
            ],
            source: _DataSource(data: assetData),
            rowsPerPage: assetData.isEmpty
                ? 1
                : assetData.length < 30
                ? assetData.length
                : 30,
            showEmptyRows: false,
          ),
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<AssetAccountsModel> data;

  _DataSource({required this.data});
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];
    return DataRow(
      cells: [
        DataCell(TableDataCell(text: item.patientId.toString())),
        DataCell(TableDataCell(text: item.name!)),
        DataCell(TableDataCell(text: HFormatter.formatStringDate(item.date))),
        DataCell(
          TableDataCell(
            text: HValidator.serviceIdValidation(item.serviceId).tr,
          ),
        ),
        DataCell(TableDataCell(text: item.debit.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
