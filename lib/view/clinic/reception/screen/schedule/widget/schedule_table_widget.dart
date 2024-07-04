import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/custom_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HScheduleDataTable extends StatelessWidget {
  const HScheduleDataTable({
    super.key,
    required this.searchResult,
  });

  final List<String> searchResult;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(HSizes.defaultSpace),
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: PaginatedDataTable(
            headingRowColor: const WidgetStatePropertyAll(HColors.accent),
            columnSpacing: HSizes.spaceBtwItems,
            columns: const [
              DataColumn(label: TableColumnLabel(text: ' # ')),
              DataColumn(label: TableColumnLabel(text: 'أسم المريض')),
              DataColumn(label: TableColumnLabel(text: 'التاريخ')),
              DataColumn(label: TableColumnLabel(text: 'نوع الخدمة')),
              DataColumn(label: TableColumnLabel(text: 'رقم التليفون')),
              DataColumn(label: TableColumnLabel(text: 'الحسابات')),
              DataColumn(label: TableColumnLabel(text: 'الحالة')),
            ],
            source: _DataSource(data: searchResult),

            rowsPerPage: 8, //searchResult.length < 8 ? searchResult.length : 8,
            // horizontalMargin: 60,
            showEmptyRows: false,
          ),
        ),
      ),
    );
  }
}

class TableColumnLabel extends StatelessWidget {
  const TableColumnLabel({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: GoogleFonts.notoNaskhArabic(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<String> data;

  _DataSource({required this.data});
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];

    return DataRow(cells: [
      const DataCell(TableDataCell(text: '1')),
      const DataCell(TableDataCell(text: 'دعاء منذر محمد عبدالمجيد')),
      DataCell(TableDataCell(
          text: DateFormat('dd-MM-yyyy').format(DateTime.now()).toString())),
      const DataCell(TableDataCell(text: 'كشف')),
      const DataCell(TableDataCell(text: '01008169644')),
      const DataCell(TableDataCell(text: 'تم الدفع')),
      const DataCell(Center(child: CustomDropDownWidget())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class TableDataCell extends StatelessWidget {
  const TableDataCell({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: GoogleFonts.cairo(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
  }
}
