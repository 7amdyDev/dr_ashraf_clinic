import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/model/finance_models.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/doctor/screen/check/widget/doctor_text_add.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_column_label.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckAccountTable extends StatefulWidget {
  const CheckAccountTable({
    super.key,
    this.appointId,
  });
  final int? appointId;

  @override
  State<CheckAccountTable> createState() => _CheckAccountTableState();
}

class _CheckAccountTableState extends State<CheckAccountTable> {
  final financeController = Get.find<FinanceController>();
  AppointmentFinance? record;
  @override
  Widget build(BuildContext context) {
    final valueKey = GlobalKey<FormState>();
    financeController.onPatientAccountListUpdated(appointId: widget.appointId);
    final List<AppointmentFinance> searchResult =
        financeController.filteredAppointmentAccountslst;
    final discountEditingController = TextEditingController();
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
                  DataColumn(label: TableColumnLabel(text: 'value_label')),
                  DataColumn(
                      label: TableColumnLabel(text: 'patient_paid_label')),
                  DataColumn(
                      label: TableColumnLabel(text: 'patient_unpaid_label')),
                ],
                source:
                    _DataSource(data: searchResult, record: record, (value) {
                  setState(() {
                    record = value;
                  });
                }),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              (record?.serviceId != 3 &&
                      record?.serviceId != 4 &&
                      record != null)
                  ? Form(
                      key: valueKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: DoctorTextAddWidget(
                        label: 'discount_label'.tr,
                        validator: HValidator.validateNumber,
                        textEditingController: discountEditingController,
                        onPressed: () {
                          int amount = int.tryParse(
                              HFormatter.convertArabicToEnglishNumbers(
                                  discountEditingController.text))!;
                          if (valueKey.currentState!.validate() &&
                              discountEditingController.text.isNotEmpty &&
                              int.tryParse(record!.fee)! >= amount) {
                            financeController.updatePatientCashReceipt(
                                record!.appointmentId,
                                record!.serviceId,
                                amount);

                            discountEditingController.clear();
                          }
                        },
                      ),
                    )
                  : const SizedBox(),
              (record?.serviceId == 3 || record?.serviceId == 4)
                  ? HFilledButton(
                      fontSize: 24,
                      text: 'delete_button'.tr,
                      onPressed: () {
                        financeController.removePatientEndoscopyService(
                            record!.appointmentId, record!.serviceId);
                      },
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<AppointmentFinance> data;
  final Function(AppointmentFinance) onSelected;
  final AppointmentFinance? record;
  // final financeController = Get.find<FinanceController>();
  // final appointmentController = Get.find<AppointmentController>();

  _DataSource(this.onSelected, {required this.record, required this.data});
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }
    final item = data[index];

    return DataRow(
        selected: record?.appointmentId == item.appointmentId &&
            record?.serviceId == item.serviceId,
        color: record?.appointmentId == item.appointmentId &&
                record?.serviceId == item.serviceId
            ? const WidgetStatePropertyAll<Color>(Colors.black12)
            : null,
        cells: [
          DataCell(TableDataCell(text: (index + 1).toString())),
          DataCell(
            TableDataCell(text: item.name),
            onTap: () {
              onSelected(item);

              // Get.dialog(FutureBuilder(
              //     future:
              //         appointmentController.getAppointmentById(item.appointmentId),
              //     builder: (context, snapshot) {
              //       if (snapshot.data != null) {
              //         return CashRecieptDialogWidget(
              //             controller: financeController,
              //             appointData: snapshot.data!,
              //             serviceId: item.serviceId);
              //       } else {
              //         return const CircularProgressIndicator();
              //       }
              //     }));
              //  financeController.accountRecordId.value = item.id!;
            },
          ),
          DataCell(TableDataCell(text: HFormatter.formatStringDate(item.date))),
          DataCell(TableDataCell(
              text: HValidator.serviceIdValidation(item.serviceId).tr)),
          DataCell(TableDataCell(text: item.fee.toString())),
          DataCell(TableDataCell(text: item.paid.toString())),
          DataCell(TableDataCell(text: (item.unPaid).toString())),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
