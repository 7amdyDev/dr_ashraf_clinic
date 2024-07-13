import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/model/expense_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_column_label.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientAccountTable extends StatelessWidget {
  const PatientAccountTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClinicController());
    final List<ExpenseModel> searchResult = controller.expenseSearchResult;
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
                  DataColumn(label: TableColumnLabel(text: 'date_label')),
                  DataColumn(
                      label: TableColumnLabel(text: 'service_type_label')),
                  DataColumn(label: TableColumnLabel(text: 'value_label')),
                  DataColumn(
                      label: TableColumnLabel(text: 'patient_paid_label')),
                  DataColumn(
                      label: TableColumnLabel(text: 'patient_unpaid_label')),
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
          ),
          const SizedBox(
            height: HSizes.spaceBtwItems,
          ),
          const SizedBox(
            height: HSizes.spaceBtwSections,
          )
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
      DataCell(
        TableDataCell(text: item.description),
        onTap: () {},
      ),
      DataCell(TableDataCell(text: item.dateTime)),
      DataCell(TableDataCell(
          text: HValidator.expenseCodeValidation(int.parse(item.expenseType))
              .tr)),
      DataCell(TableDataCell(text: item.value.toString())),
      DataCell(TableDataCell(text: item.value.toString())),

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
