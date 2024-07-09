import 'package:dr_ashraf_clinic/model/clinic_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_column_label.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientSearchTable extends StatelessWidget {
  const PatientSearchTable({super.key, required this.searchResult});

  final List<String> searchResult;

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
  final controller = Get.put(ClinicController());

  _DataSource({required this.data});
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    //  final item = data[index];
    return DataRow(cells: [
      const DataCell(TableDataCell(text: '1')),
      DataCell(
        TableDataCell(text: 'دعاء منذر محمد عبدالمجيد'),
        onTap: () {
          controller.show.value = true;
          Get.back();
        },
      ),
      const DataCell(TableDataCell(text: '01008169644')),
      const DataCell(TableDataCell(text: '30')),
      const DataCell(TableDataCell(text: 'فيكتور عمانويل سموحة')),
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
