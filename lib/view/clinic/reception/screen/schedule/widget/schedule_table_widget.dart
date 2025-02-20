import 'package:dr_ashraf_clinic/controller/appointment_controller.dart';
import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/controller/consultation_controller.dart';
import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
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
                  DataColumn(label: TableColumnLabel(text: 'referral_label')),
                  DataColumn(label: TableColumnLabel(text: 'finance_label')),
                  DataColumn(label: TableColumnLabel(text: 'status_label')),
                ],
                source: _DataSource(data: searchResult),
                rowsPerPage: searchResult.isEmpty
                    ? 1
                    : searchResult.length < 30
                        ? searchResult.length
                        : 30,
                showEmptyRows: false,
              ),
            ),
          ),
        ));
  }
}

class _DataSource extends DataTableSource {
  final List<AppointmentFinance> data;
  final _hoveredIndex = Rxn<int>();
  final _consultationController = Get.find<ConsultationController>();
  final _appointmentController = Get.find<AppointmentController>();
  final _patientController = Get.find<PatientController>();
  final _clinicController = Get.find<ClinicController>();

  _DataSource({required this.data});

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];

    return DataRow(
      color: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) {
          return HColors.primary.withValues(alpha: 0.3);
        }
        if (_appointmentController.getAppointmentStatus(item.appointmentId) ==
            4) {
          return HColors.darkerGrey.withValues(alpha: 0.3);
        }

        return null;
      }),
      cells: [
        DataCell(
          MouseRegion(
              onEnter: (_) => _hoveredIndex.value = index,
              onExit: (_) => _hoveredIndex.value = null,
              child: TableDataCell(text: (index + 1).toString())),
        ),
        DataCell(
          MouseRegion(
            onEnter: (_) => _hoveredIndex.value = index,
            onExit: (_) => _hoveredIndex.value = null,
            child: TableDataCell(text: item.name),
          ),
          onTap: () {
            _patientController.choosePatient(item.patientId);
            var route = Get.currentRoute;
            if (route == '/doctor') {
              _consultationController
                  .getConsultIdByAppointId(item.appointmentId);
              _consultationController
                  .getConsultationByPatientId(item.patientId);
              _consultationController.appointId.value = item.appointmentId;
              _clinicController.pageIndex.value = 7;
            } else {
              _clinicController.pageIndex.value = 5;
            }
          },
        ),
        DataCell(TableDataCell(text: HFormatter.formatStringDate(item.date))),
        DataCell(TableDataCell(
            text: HValidator.serviceIdValidation(item.serviceId).tr)),
        DataCell(TableDataCell(text: item.mobile)),
        DataCell(TableDataCell(text: item.referral ?? ' ')),
        DataCell(
            TableDataCell(text: item.unPaid == '0' ? 'Paid'.tr : item.unPaid)),
        DataCell(
          Center(
            child: FittedBox(
                fit: BoxFit.scaleDown,
                child: CustomDropDownWidget(
                  statusId: _appointmentController
                      .getAppointmentStatus(item.appointmentId),
                  onSelected: (value) {
                    var appointment = _appointmentController.appointListByDate
                        .firstWhere(
                            (record) => record.id == item.appointmentId);
                    var updatedItem = appointment.copyWith(
                        statusId: value,
                        date: HFormatter.formatStringDate(item.date,
                            reversed: true));
                    _appointmentController.updateAppointment(updatedItem);
                  },
                )),
          ),
        )
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
