import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/model/online_reserv_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_column_label.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/reserve_checkbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HOnlineReservationTable extends StatelessWidget {
  const HOnlineReservationTable({
    super.key,
    required this.onlineReserv,
  });

  final List<OnlineReservModel> onlineReserv;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(HSizes.defaultSpace),
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Obx(
            () => PaginatedDataTable(
              headingRowHeight: 48,
              horizontalMargin: 12,
              headingRowColor: const WidgetStatePropertyAll(HColors.accent),
              columnSpacing: 12,
              columns: const [
                DataColumn(label: TableColumnLabel(text: ' # ')),
                DataColumn(label: TableColumnLabel(text: 'patient_name_label')),
                DataColumn(label: TableColumnLabel(text: 'date_label')),
                DataColumn(label: TableColumnLabel(text: 'telephone_label')),
                DataColumn(
                    label: TableColumnLabel(text: 'request_checkbox_label')),
              ],
              source: _DataSource(data: onlineReserv),
              rowsPerPage: onlineReserv.isEmpty
                  ? 1
                  : onlineReserv.length < 8
                      ? onlineReserv.length
                      : 8,
              showEmptyRows: false,
            ),
          ),
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<OnlineReservModel> data;
  var clinicController = Get.put(ClinicController());
  _DataSource({required this.data});
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];
    return DataRow(cells: [
      DataCell(TableDataCell(text: (index + 1).toString())),
      DataCell(TableDataCell(text: item.name)),
      DataCell(TableDataCell(text: (item.dateTime))),
      DataCell(TableDataCell(text: item.mobile)),
      DataCell(Center(child: ReserveCheckboxWidget(appointId: item.id!)))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
