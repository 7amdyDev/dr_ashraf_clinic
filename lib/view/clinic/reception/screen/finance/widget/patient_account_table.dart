import 'package:dr_ashraf_clinic/controller/appointment_controller.dart';
import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/model/finance_models.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/cash_reciept_dialog.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_column_label.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/drop_down_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientAccountTable extends StatelessWidget {
  PatientAccountTable({
    super.key,
  });
  final financeController = Get.find<FinanceController>();
  @override
  Widget build(BuildContext context) {
    final List<AppointmentFinance> searchResult =
        financeController.totalAppointmentAccountslst;

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
                      label: TableColumnLabel(text: 'patient_name_label')),
                  DataColumn(label: TableColumnLabel(text: 'date_label')),
                  DataColumn(
                      label: TableColumnLabel(text: 'service_type_label')),
                  DataColumn(label: TableColumnLabel(text: 'clinic_button')),
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
          // const SizedBox(
          //   height: HSizes.spaceBtwSections,
          // )
        ],
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<AppointmentFinance> data;
  final financeController = Get.find<FinanceController>();
  final appointmentController = Get.find<AppointmentController>();

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
        TableDataCell(text: item.name),
        onTap: () {
          Get.dialog(FutureBuilder(
              future:
                  appointmentController.getAppointmentById(item.appointmentId),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return CashRecieptDialogWidget(
                      controller: financeController,
                      appointData: snapshot.data!,
                      serviceId: item.serviceId);
                } else {
                  return const CircularProgressIndicator();
                }
              }));
          //  financeController.accountRecordId.value = item.id!;
        },
      ),
      DataCell(TableDataCell(text: HFormatter.formatStringDate(item.date))),
      DataCell(TableDataCell(
          text: HValidator.serviceIdValidation(item.serviceId).tr)),
      DataCell(TableDataCell(
          text: clinicController.getClinicBranchName(
              clinicBranchId: item.clinicId))),
      DataCell(TableDataCell(text: item.fee.toString())),
      DataCell(TableDataCell(text: item.paid.toString())),
      DataCell(TableDataCell(text: item.unPaid.toString())),

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
