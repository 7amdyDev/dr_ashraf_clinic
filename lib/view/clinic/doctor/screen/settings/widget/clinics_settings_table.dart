import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/model/clinic_models.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/data_text_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_column_label.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClinicsSettingsTable extends StatefulWidget {
  const ClinicsSettingsTable({super.key});

  @override
  State<ClinicsSettingsTable> createState() => _ClinicsSettingsTableState();
}

class _ClinicsSettingsTableState extends State<ClinicsSettingsTable> {
  final clinicController = Get.find<ClinicController>();
  Fee? record;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    TextEditingController feeTextController = TextEditingController();

    final List<Fee> searchResult = clinicController.feeList;
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
                    DataColumn(label: TableColumnLabel(text: 'clinic_label')),
                    DataColumn(
                        label: TableColumnLabel(text: 'service_type_label')),
                    DataColumn(label: TableColumnLabel(text: 'value_label')),
                  ],
                  source:
                      _DataSource(data: searchResult, id: record?.id, (value) {
                    setState(() {
                      record = value;
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
              const SizedBox(
                height: HSizes.spaceBtwSections,
              ),
              record != null
                  ? SizedBox(
                      width: width / 2,
                      child: Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // DataTextWidget(
                            //   label: 'Clinic',
                            //   value: clinicController.getClinicBranchName(
                            //       clinicBranchId: record!.clinicId),
                            // ),
                            // DataTextWidget(
                            //   label: 'service_type_label'.tr,
                            //   value: HValidator.serviceIdValidation(
                            //           record!.serviceId)
                            //       .tr,
                            // ),
                            DataTextWidget(
                              label: 'value_label'.tr,
                              textEditingController: feeTextController,
                            ),
                            HFilledButton(
                                fontSize: 22,
                                onPressed: () {
                                  debugPrint('updated');
                                },
                                text: 'update_button')
                          ],
                        ),
                      )),
                    )
                  : Container()
            ],
          ),
        ));
  }
}

class _DataSource extends DataTableSource {
  final List<Fee> data;
  final clinicController = Get.find<ClinicController>();
  final Function(Fee) onSelected;
  final int? id;
  _DataSource(this.onSelected, {required this.id, required this.data});
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];
    return DataRow(
        selected: id == item.id,
        color: id == item.id
            ? const WidgetStatePropertyAll<Color>(Colors.black12)
            : null,
        cells: [
          DataCell(TableDataCell(text: (index + 1).toString())),
          DataCell(
            TableDataCell(
                text: clinicController.getClinicBranchName(
                    clinicBranchId: item.clinicId)),
            onTap: () {
              onSelected(item);
            },
          ),
          DataCell(
            TableDataCell(
                text: HValidator.serviceIdValidation(item.serviceId).tr),
          ),
          DataCell(
            TableDataCell(text: item.fee.toString()),
          ),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
