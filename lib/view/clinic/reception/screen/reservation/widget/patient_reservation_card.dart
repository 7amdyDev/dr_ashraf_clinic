import 'package:dr_ashraf_clinic/controller/appointment_controller.dart';
import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/model/appointment_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/data_text_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/reservation_dropdownmenu_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/checkbox_table_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/pick_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientReservationCardWidget extends StatelessWidget {
  const PatientReservationCardWidget({
    super.key,
    required this.dateController,
    required this.id,
    required this.name,
    required this.mobile,
  });

  final TextEditingController dateController;
  final int? id;
  final String? name;
  final String? mobile;
  @override
  Widget build(BuildContext context) {
    double width = HelperFunctions.clinicPagesWidth();
    final dateKey = GlobalKey<FormState>();
    AppointmentModel appointment;
    var controller = Get.put(AppointmentController());
    var financeController = Get.put(FinanceController());
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(HSizes.defaultSpace),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DataTextWidget(
                    label: 'id_no_label'.tr,
                    enable: false,
                    width: width / 6,
                    value: id.toString(),
                  ),
                  DataTextWidget(
                    label: 'name_label'.tr,
                    value: name,
                    width: width / 4,
                    textFontSize: 16,
                    enable: false,
                  ),
                  DataTextWidget(
                    label: 'telephone_label'.tr,
                    value: mobile,
                    width: width / 4,
                    enable: false,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DataTextWidget(
                    label: 'service_type_label'.tr,
                    width: width / 6,
                    child: ServiceTypeDropDownMenu(
                      serviceId: controller.serviceId.value,
                      onSelected: (value) {
                        controller.serviceId.value = value;
                      },
                    ),
                  ),
                  DataTextWidget(
                    width: width / 4,
                    label: 'date_label'.tr,
                    child: Form(
                      key: dateKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: PickDateWidget(
                        width: width / 4,
                        validator: HValidator.validateText,
                        dateController: dateController,
                      ),
                    ),
                  ),
                  DataTextWidget(
                      label: 'paid_label'.tr,
                      width: width / 4,
                      child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TableCheckBoxWidget()))
                ],
              ),
              HFilledButton(
                  text: 'save_button',
                  fontSize: 22,
                  onPressed: () {
                    appointment = AppointmentModel(
                        id: controller.appointmentlst.length + 1,
                        status: 0,
                        mobile: mobile!,
                        patientId: id!,
                        serviceId: controller.serviceId.value,
                        dateTime: dateController.text);
                    if (dateKey.currentState!.validate()) {
                      controller.addAppointment(appointment);
                      controller.getPatientAppointment(id!);

                      if (controller.paid.value) {
                        financeController.addAssetCashOnHand(
                            appointmentId: controller.appointmentlst.length,
                            patientId: id!,
                            dateTime: HFormatter.formatDate(DateTime.now()),
                            serviceId: controller.serviceId.value,
                            value: 400,
                            debit: 400);
                        financeController.addAccountRecievable(
                          appointmentId: controller.appointmentlst.length,
                          patientId: id!,
                          serviceId: controller.serviceId.value,
                          dateTime: dateController.text,
                          value: 400,
                          debit: 0,
                        );
                      } else {
                        financeController.addAccountRecievable(
                          appointmentId: controller.appointmentlst.length,
                          patientId: id!,
                          serviceId: controller.serviceId.value,
                          dateTime: dateController.text,
                          value: 400,
                          debit: 400,
                        );
                        financeController.addAssetCashOnHand(
                            appointmentId: controller.appointmentlst.length,
                            patientId: id!,
                            dateTime: HFormatter.formatDate(DateTime.now()),
                            serviceId: controller.serviceId.value,
                            value: 400,
                            debit: 0);
                      }
                    }
                  })
            ],
          )),
    );
  }
}
