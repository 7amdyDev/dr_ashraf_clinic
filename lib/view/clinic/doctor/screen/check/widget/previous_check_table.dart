import 'package:dr_ashraf_clinic/controller/consultation_controller.dart';
import 'package:dr_ashraf_clinic/model/consultation_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_column_label.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreviousCheckTable extends StatefulWidget {
  const PreviousCheckTable(
      {super.key, required this.searchResult, required this.width});

  final List<ConsultationModel> searchResult;
  final double width;
  @override
  State<PreviousCheckTable> createState() => _PreviousCheckTableState();
}

class _PreviousCheckTableState extends State<PreviousCheckTable> {
  int? consultId;
  @override
  Widget build(BuildContext context) {
    // filter consultation list
    List<ConsultationModel> filteredConsultation =
        widget.searchResult.where((consult) {
      return DateTime.parse(consult.dateTime)
          .isBefore(DateTime.now().subtract(const Duration(days: 1)));
    }).toList();

    return widget.searchResult.isNotEmpty
        ? SizedBox(
            width: widget.width,
            child: PaginatedDataTable(
              headingRowHeight: 48,
              horizontalMargin: 12,
              headingRowColor: const WidgetStatePropertyAll(HColors.accent),
              columnSpacing: 12,
              columns: const [
                DataColumn(
                    label: TableColumnLabel(
                  text: '#',
                )),
                DataColumn(
                    label: TableColumnLabel(
                  text: 'date_label',
                )),
                DataColumn(
                    label: TableColumnLabel(
                  text: 'service_type_label',
                )),
              ],
              source: _DataSource(
                  data: filteredConsultation, consultId: consultId, (value) {
                setState(() {
                  consultId = value;
                });
              }),

              rowsPerPage: filteredConsultation.isEmpty
                  ? 1
                  : widget.searchResult.length < 8
                      ? widget.searchResult.length
                      : 8,
              // horizontalMargin: 60,
              showEmptyRows: false,
            ),
          )
        : const SizedBox();
  }
}

class _DataSource extends DataTableSource {
  final List<ConsultationModel> data;
  final consulationController = Get.find<ConsultationController>();
  final Function(int) onSelected;
  final int? consultId;
  _DataSource(this.onSelected, {required this.consultId, required this.data});
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];
    return DataRow(
        selected: consultId == item.id,
        color: consultId == item.id
            ? const WidgetStatePropertyAll<Color>(Colors.black12)
            : null,
        cells: [
          DataCell(TableDataCell(text: (index + 1).toString())),
          DataCell(
            TableDataCell(text: HFormatter.formatStringDate(item.dateTime)),
            onTap: () {
              consulationController.getConsultAllData(id: item.id);
              onSelected(item.id!);
            },
          ),
          DataCell(TableDataCell(
              text: HValidator.serviceIdValidation(item.serviceId).tr)),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
