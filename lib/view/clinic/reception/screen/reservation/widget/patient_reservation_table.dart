import 'package:dr_ashraf_clinic/controller/appointment_controller.dart';
import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/model/appointment_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_column_label.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientReservationTable extends StatefulWidget {
  const PatientReservationTable({
    super.key,
    required this.searchResult,
  });
  final List<AppointmentModel> searchResult;

  @override
  State<PatientReservationTable> createState() =>
      _PatientReservationTableState();
}

class _PatientReservationTableState extends State<PatientReservationTable> {
  int? appointId;

  @override
  Widget build(BuildContext context) {
    final appointmentController = Get.find<AppointmentController>();
    return Obx(() => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: PaginatedDataTable(
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
                    DataColumn(label: TableColumnLabel(text: 'status_label')),
                  ],
                  source: _DataSource(
                      data: widget.searchResult, appointId: appointId, (value) {
                    setState(() {
                      appointId = value;
                    });
                  }),
                  rowsPerPage: widget.searchResult.isEmpty
                      ? 1
                      : widget.searchResult.length < 8
                          ? widget.searchResult.length
                          : 8,
                  showEmptyRows: false,
                ),
              ),
              const SizedBox(
                height: HSizes.spaceBtwItems,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  appointId != null
                      ? HFilledButton(
                          text: 'delete_button',
                          fontSize: 22,
                          onPressed: () {
                            appointmentController.removeAppointment(appointId!);
                            setState(() {
                              appointId = null;
                            });
                          },
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ));
  }
}

class _DataSource extends DataTableSource {
  final List<AppointmentModel> data;
  var controller = Get.put(PatientController());
  var financeController = Get.put(FinanceController());
  final Function(int) onSelected;
  final int? appointId;
  _DataSource(this.onSelected, {required this.appointId, required this.data});

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];
    return DataRow(
        selected: appointId == item.id,
        color: appointId == item.id
            ? const WidgetStatePropertyAll<Color>(Colors.black12)
            : null,
        cells: [
          DataCell(TableDataCell(text: '${index + 1}')),
          DataCell(
            FutureBuilder(
                future: controller.getPatient(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return TableDataCell(text: snapshot.data!.name);
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
            onTap: () {
              onSelected(item.id!);
            },
          ),
          DataCell(TableDataCell(text: HFormatter.formatStringDate(item.date))),
          DataCell(TableDataCell(
              text: HValidator.serviceIdValidation(item.serviceId).tr)),
          DataCell(TableDataCell(
              text: HValidator.statusIdValidation(item.statusId).tr)),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
