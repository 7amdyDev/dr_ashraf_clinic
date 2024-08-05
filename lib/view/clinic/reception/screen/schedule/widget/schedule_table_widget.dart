import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/model/appointment_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/custom_dropdown_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_column_label.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HScheduleDataTable extends StatelessWidget {
  const HScheduleDataTable({
    super.key,
    required this.searchResult,
  });

  final List<AppointmentModel> searchResult;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(HSizes.spaceBtwItems),
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
                  DataColumn(
                      label: TableColumnLabel(text: 'patient_name_label')),
                  DataColumn(label: TableColumnLabel(text: 'date_label')),
                  DataColumn(
                      label: TableColumnLabel(text: 'service_type_label')),
                  DataColumn(label: TableColumnLabel(text: 'telephone_label')),
                  //  DataColumn(label: TableColumnLabel(text: 'finance_label')),
                  DataColumn(label: TableColumnLabel(text: 'status_label')),
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
        ));
  }
}

class _DataSource extends DataTableSource {
  final List<AppointmentModel> data;
  final patientController = Get.put(PatientController());
  final financeController = Get.put(FinanceController());

  _DataSource({required this.data});
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];

    return DataRow(cells: [
      DataCell(TableDataCell(text: (index + 1).toString())),
      DataCell(TableDataCell(
          text: patientController.getPatientById(item.patientId).name)),
      DataCell(TableDataCell(text: item.dateTime)),
      DataCell(TableDataCell(
          text: HValidator.serviceIdValidation(item.serviceId).tr)),
      DataCell(TableDataCell(
          text: patientController.getPatientById(item.patientId).mobile)),
      // DataCell(TableDataCell(
      //     text: financeController.getAppointmentAccount(item.).toString())),
      DataCell(Center(
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: CustomDropDownWidget(statusId: item.status)))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
