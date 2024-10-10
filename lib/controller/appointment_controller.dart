import 'dart:async';
import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/controller/finance_controller.dart';
import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
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
  final _patientController = Get.find<PatientController>();
  RxList<AppointmentModel> appointmentlst = <AppointmentModel>[].obs;
  RxList<AppointmentModel> patientAppointlst = <AppointmentModel>[].obs;
  RxList<AppointmentModel> appointListByDate = <AppointmentModel>[].obs;
  RxInt serviceId = 1.obs;
  RxBool paid = false.obs;
  RxBool appointmentsLoading = false.obs;
  bool scheduleByDate = false;

  @override
  void onInit() {
    appointListByDate.clear();
    startPeriodicUpdate();
    super.onInit();
  }

  Future<void> startPeriodicUpdate() async {
    // Set the duration for the periodic execution
    const duration = Duration(seconds: 2);

    // Create a Timer that runs the function periodically
    final timer = Timer.periodic(duration, (timer) {
      // You can add your periodic task logic here.
      if (!scheduleByDate) {
        getAppointsByDate().then((_) {
          _financeController.getAppointsFinanceByDate();
        });
      }

      // Uncomment the following line to stop the timer after a certain condition is met
      if (scheduleByDate) {
        timer.cancel();
        debugPrint('Timer Cancel');
      }
    });
    while (timer.isActive) {
      // waiting for the same time duration to check if timer is still active after it
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  Future<void> addAppointment(AppointmentModel appointment) async {
    appointmentsLoading.value = true;
    try {
      var response = await _appointmentApi.create(appointment);

      if (response.statusCode == 201 && response.body != null) {
        HelperFunctions.showSnackBar('The Appointment Added Successfully');
        getPatientAppointment(appointment.patientId);
        addAppointmentFinance(response.body!);
        _financeController.onPatientAccountListUpdated();
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
        _financeController.getAppointsFinanceByDate();
        HelperFunctions.showSnackBar('Appointment Updated Successfully');
      }
    } finally {}
  }

  Future<void> removeAppointment(int appointId) async {
    try {
      var response = await _appointmentApi.remove(appointId);

      if (response.statusCode == 200 && response.body != null) {
        // patientId.value = (response.body!.id!);
        getPatientAppointment(_patientController.patientId.value);
        _financeController.getAppointsFinanceByDate();
        HelperFunctions.showSnackBar('Appointment Deleted Successfully');
      }
    } finally {}
  }

  Future<void> getAppointsByDate({DateTime? date}) async {
    (appointmentsLoading) {
      return;
    };

    if (date == null) {
      appointmentsLoading.value = true;
      try {
        var response =
            await _appointmentApi.getByDate(DateUtils.dateOnly(DateTime.now()));
        if (response.statusCode == 200 && response.body != null) {
          appointListByDate.clear();
          appointListByDate.addAll(response.body!);
        }
      } finally {
        appointmentsLoading.value = false;
      }
    } else {
      appointmentsLoading.value = true;

      scheduleByDate = true;

      // Check if the choosen date is today date to start to start the timer
      if (date == DateUtils.dateOnly(DateTime.now())) {
        scheduleByDate = false;
        startPeriodicUpdate();
      }
      try {
        var response = await _appointmentApi.getByDate(date);

        if (response.statusCode == 200 && response.body != null) {
          appointListByDate.clear();
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
    appointmentsLoading.value = true;
    try {
      var response = await _appointmentApi.getById(appId);

      if (response.statusCode == 200 && response.body != null) {
        patientAppointlst.clear();
        patientAppointlst.add(response.body!);
      }
      return patientAppointlst
          .firstWhere((appointment) => appointment.id == appId);
    } finally {
      appointmentsLoading.value = false;
    }
  }

  int getAppointmentStatus(int appId) {
    return appointListByDate
        .firstWhere((element) => element.id == appId)
        .statusId;
  }

  Future<void> getPatientAppointment(int id) async {
    (appointmentsLoading) {
      return;
    };

    appointmentsLoading.value = true;
    try {
      var response = await _appointmentApi.getByPatientId(id);

      if (response.statusCode == 200 && response.body != null) {
        patientAppointlst.clear();
        patientAppointlst.addAll(response.body!);
      }
    } finally {
      appointmentsLoading.value = false;
    }
  }

  void addAppointmentFinance(AppointmentModel appointment) {
    int serviceFee = _clinicController.feeList
        .firstWhere((fee) =>
            fee.serviceId == appointment.serviceId &&
            fee.clinicId == appointment.clinicId)
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
