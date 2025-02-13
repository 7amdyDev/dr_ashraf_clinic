import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/model/consultation_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_column_label.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExaminationSearchTable extends StatefulWidget {
  const ExaminationSearchTable({super.key});
  @override
  State<ExaminationSearchTable> createState() => _ExaminationSearchTableState();
}

class _ExaminationSearchTableState extends State<ExaminationSearchTable> {
  String? medicineKey;
  final clinicController = Get.find<ClinicController>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;

    final List<ExaminationModel> searchResult =
        clinicController.dbExaminationSearch;
    return Obx(() => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: width / 1.5,
                child: PaginatedDataTable(
                  headingRowHeight: 48,
                  horizontalMargin: 12,
                  headingRowColor: const WidgetStatePropertyAll(HColors.accent),
                  columnSpacing: 12,
                  columns: const [
                    DataColumn(label: TableColumnLabel(text: '#')),
                    DataColumn(
                        label:
                            TableColumnLabel(text: 'examination_name_label')),
                    DataColumn(label: TableColumnLabel(text: ' ')),
                  ],
                  source: _DataSource(
                      data: searchResult, examinationKey: medicineKey, (value) {
                    setState(() {
                      medicineKey = value;
                    });
                  }),
                  rowsPerPage: searchResult.isEmpty
                      ? 1
                      : searchResult.length < 7
                          ? searchResult.length
                          : 7,
                  showEmptyRows: false,
                ),
              ),
            ],
          ),
        ));
  }
}

class _DataSource extends DataTableSource {
  final List<ExaminationModel> data;
  final clinicController = Get.find<ClinicController>();
  final Function(String) onSelected;
  final String? examinationKey;
  _DataSource(this.onSelected,
      {required this.examinationKey, required this.data});
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];
    return DataRow(
        selected: examinationKey == item.key,
        color: examinationKey == item.key
            ? const WidgetStatePropertyAll<Color>(Colors.black12)
            : null,
        cells: [
          DataCell(TableDataCell(text: (index + 1).toString())),
          DataCell(
            TableDataCell(text: item.name),
            onTap: () {
              onSelected(item.key!);
            },
          ),
          examinationKey == item.key
              ? DataCell(
                  Center(
                    child: InkWell(
                      child: const Icon(
                        size: 30,
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                      onTap: () {
                        Get.dialog(AlertDialog(
                          backgroundColor: HColors.primaryBackground,
                          elevation: 10,
                          title: const Center(
                            child: Text(
                              'Are You Sure',
                              style: TextStyle(
                                color: HColors.primary,
                              ),
                            ),
                          ),
                          content: Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(children: [
                              TextSpan(
                                text: '${item.name}\n',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const TextSpan(
                                text: '\n',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const TextSpan(
                                text: 'will be deleted',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                          ),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  child: const Text(
                                    'No',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.back(); // Close the dialog
                                  },
                                ),
                                TextButton(
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    // Perform the action
                                    clinicController
                                        .deleteExaminationFromDB(item.key!);
                                    clinicController.dbExaminationSearch
                                        .removeAt(index);
                                    Get.back();
                                  },
                                ),
                              ],
                            )
                          ],
                        ));
                      },
                    ),
                  ),
                )
              : const DataCell(SizedBox()),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
