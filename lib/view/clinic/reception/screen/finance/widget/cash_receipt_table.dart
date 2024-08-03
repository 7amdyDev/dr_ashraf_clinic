import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/model/finance_models.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_column_label.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CashReceiptTable extends StatelessWidget {
  const CashReceiptTable({
    super.key,
    required this.searchResult,
  });

  final List<AssetAccountsModel> searchResult;

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
                source: _DataSource(data: searchResult),

                rowsPerPage: searchResult.isEmpty
                    ? 1
                    : searchResult.length < 8
                        ? searchResult.length
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
  var patientController = Get.put(PatientController());
  var financeController = Get.put(FinanceController());
  _DataSource({required this.data});
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }
    final item = data[index];
    return DataRow(
        color: financeController.accountRecordId.value == item.id
            ? WidgetStateProperty.all(Colors.grey)
            : null,
        cells: [
          DataCell(TableDataCell(text: item.patientId.toString())),
          DataCell(
            TableDataCell(
                text: patientController.getPatientById(item.patientId).name),
            onTap: () {
              financeController.accountRecordId.value = item.id!;
            },
          ),
          DataCell(TableDataCell(text: item.dateTime)),
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
