import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/model/finance_models.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_column_label.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CashReceiptTable extends StatefulWidget {
  const CashReceiptTable({
    super.key,
    required this.searchResult,
  });

  final List<AssetAccountsModel> searchResult;

  @override
  State<CashReceiptTable> createState() => _CashReceiptTableState();
}

class _CashReceiptTableState extends State<CashReceiptTable> {
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
                  DataColumn(label: TableColumnLabel(text: 'id_no_label')),
                  DataColumn(
                      label: TableColumnLabel(text: 'patient_name_label')),
                  DataColumn(label: TableColumnLabel(text: 'date_label')),
                  DataColumn(
                      label: TableColumnLabel(text: 'service_type_label')),
                  DataColumn(
                      label: TableColumnLabel(text: 'patient_paid_label')),
                ],
                source: _DataSource(data: widget.searchResult, () {
                  setState(() {});
                }),

                rowsPerPage: widget.searchResult.isEmpty
                    ? 1
                    : widget.searchResult.length < 8
                        ? widget.searchResult.length
                        : 8,
                // rowsPerPage:
                //     searchResult.length < 8 ? searchResult.length : 8 ?? 0,
                // horizontalMargin: 60,
                showEmptyRows: false,
              )),
        ));
  }
}

class _DataSource extends DataTableSource {
  final List<AssetAccountsModel> data;
  final Function selected;
  var patientController = Get.find<PatientController>();
  var financeController = Get.find<FinanceController>();
  _DataSource(this.selected, {required this.data});
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }
    final item = data[index];
    var patient = patientController.patientList
        .firstWhere((patient) => patient.id == item.patientId);
    return DataRow(
        color: financeController.accountRecordId.value == item.id
            ? WidgetStateProperty.all(Colors.black12)
            : null,
        cells: [
          DataCell(TableDataCell(text: item.patientId.toString())),
          DataCell(
            TableDataCell(text: patient.name),
            onTap: () {
              financeController.accountRecordId.value = item.id!;
              selected();
            },
          ),
          DataCell(TableDataCell(text: HFormatter.formatStringDate(item.date))),
          DataCell(TableDataCell(
              text: HValidator.serviceIdValidation(item.serviceId).tr)),
          DataCell(TableDataCell(text: item.debit.toString())),

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
