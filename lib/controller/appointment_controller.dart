import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/db/appointment_api.dart';
import 'package:dr_ashraf_clinic/model/appointment_model.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController {
  final _appointmentApi = Get.find<AppointmentApi>();
  final _financeController = Get.find<FinanceController>();
  final _clinicController = Get.find<ClinicController>();
  RxList<AppointmentModel> appointmentlst = <AppointmentModel>[].obs;
  RxList<AppointmentModel> patientAppointlst = <AppointmentModel>[].obs;
  RxList<AppointmentModel> appointListByDate = <AppointmentModel>[].obs;
  RxInt serviceId = 1.obs;
  RxBool paid = false.obs;
  RxBool appointmentsLoading = false.obs;

  @override
  void onInit() {
    appointListByDate.clear();
    getAppointsByDate();
    super.onInit();
  }

  Future<void> addAppointment(AppointmentModel appointment) async {
    appointmentsLoading.value = true;
    try {
      var response = await _appointmentApi.create(appointment);

      if (response.statusCode == 201 && response.body != null) {
        HelperFunctions.showSnackBar('The Appointment Added Successfully');
        getPatientAppointment(appointment.patientId);
        addAppointmentFinance(response.body!);
      }
    } finally {
      appointmentsLoading.value = false;
    }
  }

  Future<void> updateAppointment(AppointmentModel appointment) async {
    try {
      var response = await _appointmentApi.update(appointment);

      if (response.statusCode == 201 && response.body != null) {
        // patientId.value = (response.body!.id!);
        getAppointsByDate();
        HelperFunctions.showSnackBar('Appointment Updated Successfully');
      }
    } finally {}
  }

  Future<void> getAppointsByDate({DateTime? date}) async {
    appointListByDate.clear();
    if (date == null) {
      appointmentsLoading.value = true;
      try {
        var response =
            await _appointmentApi.getByDate(DateUtils.dateOnly(DateTime.now()));

        if (response.statusCode == 200 && response.body != null) {
          appointListByDate.addAll(response.body!);
        }
      } finally {
        appointmentsLoading.value = false;
      }
    } else {
      appointmentsLoading.value = true;
      try {
        var response = await _appointmentApi.getByDate(date);

        if (response.statusCode == 200 && response.body != null) {
          appointListByDate.addAll(response.body!);
        }
      } finally {
        appointmentsLoading.value = false;
      }
    }
  }

  // String getAppointmentDateById(int appId) {
  //   return appointmentlst.firstWhere((element) => element.id == appId).date;
  // }

  Future<AppointmentModel> getAppointmentById(int appId) async {
    appointListByDate.clear();
    appointmentsLoading.value = true;
    try {
      var response = await _appointmentApi.getById(appId);

      if (response.statusCode == 200 && response.body != null) {
        appointListByDate.add(response.body!);
      }
      return appointListByDate.first;
    } finally {
      appointmentsLoading.value = false;
    }
  }

  int getAppointmentService(int appId) {
    return appointmentlst
        .firstWhere((element) => element.id == appId)
        .serviceId;
  }

  Future<void> getPatientAppointment(int id) async {
    patientAppointlst.clear();
    appointmentsLoading.value = true;
    try {
      var response = await _appointmentApi.getByPatientId(id);

      if (response.statusCode == 200 && response.body != null) {
        patientAppointlst.addAll(response.body!);
      }
    } finally {
      appointmentsLoading.value = false;
    }
  }

  void addAppointmentFinance(AppointmentModel appointment) {
    int serviceFee = _clinicController.servicesId
        .firstWhere((service) => service.id == appointment.serviceId)
        .fee;
    if (paid.value) {
      _financeController.addAssetCashOnHand(
          appointmentId: appointment.id!,
          patientId: appointment.patientId,
          date: HFormatter.formatDate(DateTime.now(), reversed: true),
          serviceId: appointment.serviceId,
          fee: serviceFee,
          debit: serviceFee);

      _financeController.addAccountRecievable(
        appointmentId: appointment.id!,
        patientId: appointment.patientId,
        serviceId: appointment.serviceId,
        date: HFormatter.formatDate(DateTime.now(), reversed: true),
        fee: 0,
        debit: 0,
      );
    } else {
      _financeController.addAssetCashOnHand(
          appointmentId: appointment.id!,
          patientId: appointment.patientId,
          date: HFormatter.formatDate(DateTime.now(), reversed: true),
          serviceId: appointment.serviceId,
          fee: 0,
          debit: 0);

      _financeController.addAccountRecievable(
        appointmentId: appointment.id!,
        patientId: appointment.patientId,
        serviceId: appointment.serviceId,
        date: HFormatter.formatDate(DateTime.now(), reversed: true),
        fee: serviceFee,
        debit: serviceFee,
      );
    }
  }
}
// if (controller.paid.value) {
                      //   financeController.addAssetCashOnHand(
                      //       appointmentId: controller.appointmentlst.length,
                      //       patientId: id!,
                      //       dateTime: HFormatter.formatDate(DateTime.now()),
                      //       serviceId: controller.serviceId.value,
                      //       fee: 400,
                      //       debit: 400);
                      //   financeController.addAccountRecievable(
                      //     appointmentId: controller.appointmentlst.length,
                      //     patientId: id!,
                      //     serviceId: controller.serviceId.value,
                      //     dateTime: dateController.text,
                      //     fee: 0,
                      //     debit: 0,
                      //   );
                      // } else {
                      //   financeController.addAccountRecievable(
                      //     appointmentId: controller.appointmentlst.length,
                      //     patientId: id!,
                      //     serviceId: controller.serviceId.value,
                      //     dateTime: dateController.text,
                      //     fee: 400,
                      //     debit: 400,
                      //   );
                      //   financeController.addAssetCashOnHand(
                      //       appointmentId: controller.appointmentlst.length,
                      //       patientId: id!,
                      //       dateTime: HFormatter.formatDate(DateTime.now()),
                      //       serviceId: controller.serviceId.value,
                      //       fee: 0,
                      //       debit: 0);
                      // }