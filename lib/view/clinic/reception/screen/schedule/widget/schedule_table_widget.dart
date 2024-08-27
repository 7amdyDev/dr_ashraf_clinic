import 'package:dr_ashraf_clinic/controller/appointment_controller.dart';
import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/controller/consultation_controller.dart';
import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/db/consultation_api.dart';
import 'package:dr_ashraf_clinic/model/finance_models.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
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

  final List<AppointmentFinance> searchResult;

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
                  DataColumn(label: TableColumnLabel(text: 'finance_label')),
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
  final List<AppointmentFinance> data;
  final consultationController = Get.find<ConsultationController>();
  final appointmentController = Get.find<AppointmentController>();
  final patientController = Get.find<PatientController>();
  final clinicController = Get.find<ClinicController>();
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
          patientController.choosePatient(item.patientId);
          var route = Get.currentRoute;
          if (route == '/doctor') {
            consultationController.getConsultIdByAppointId(item.appointmentId);
            consultationController.getConsultationByPatientId(item.patientId);
            clinicController.doctorPageIndex.value = 7;
          }
        },
      ),
      DataCell(TableDataCell(text: HFormatter.formatStringDate(item.date))),
      DataCell(TableDataCell(
          text: HValidator.serviceIdValidation(item.serviceId).tr)),
      DataCell(TableDataCell(text: item.mobile)),
      DataCell(
          TableDataCell(text: item.unPaid == '0' ? 'Paid'.tr : item.unPaid)),
      HFormatter.formatStringDate(item.date) ==
              HFormatter.formatDate(
                DateTime.now(),
              )
          ? DataCell(
              Center(
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CustomDropDownWidget(
                      statusId: appointmentController
                          .getAppointmentStatus(item.appointmentId),
                      onSelected: (value) {
                        var appointment =
                            appointmentController.appointListByDate.firstWhere(
                                (record) => record.id == item.appointmentId);
                        var updatedItem = appointment.copyWith(
                            statusId: value,
                            date: HFormatter.formatStringDate(item.date,
                                reversed: true));
                        appointmentController.updateAppointment(updatedItem);
                      },
                    )),
              ),
            )
          : DataCell(TableDataCell(
              text: HValidator.statusIdValidation(appointmentController
                      .getAppointmentStatus(item.appointmentId))
                  .tr)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
