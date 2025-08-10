// calendar_controller.dart
import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/controller/reservation_limit_controller.dart';
import 'package:dr_ashraf_clinic/model/online_reserv_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarController extends GetxController {
  // Get the ClinicController and ReservationLimitController instances
  final clinicController = Get.find<ClinicController>();
  final reservationLimitController = Get.find<ReservationLimitController>();

  final currentDate = DateTime.now().obs;
  final selectedClinic = '1'.obs;
  final onlineReservations = <OnlineReservModel>[].obs;
  final selectedDate = Rx<DateTime?>(null);

  // Text editing controllers and form keys
  final dateController = TextEditingController();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final nameKey = GlobalKey<FormState>();
  final mobileKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchReservations();
    // Listen for changes in the online reservations data
    clinicController.onlineReservData.listen((_) {
      fetchReservations();
    });
    // Listen for changes in the selected clinic to update the calendar
    selectedClinic.listen((_) {
      fetchReservations();
      selectedDate.value = null;
      dateController.clear(); // Reset selected date when clinic changes
    });
  }

  // --- NEW LOGIC FOR RESERVATION LIMIT ---
  // Get the reservation limit based on the selected clinic
  int get reservationLimit {
    final limits = reservationLimitController.reservationLimit.value;
    if (limits == null) {
      // Return a default limit if data hasn't loaded yet
      return 1;
    }
    // The Smouha clinic is assumed to be '1' and Agamy to be '2'
    if (selectedClinic.value == '1') {
      return limits.smouhaLimit;
    } else {
      return limits.agamyLimit;
    }
  }

  // Fetches reservation data and updates the reactive list
  void fetchReservations() {
    //  clinicController.getOnlineReservationData(); // This should be called elsewhere if it's the only place
    onlineReservations.clear();
    onlineReservations.addAll(
      clinicController.onlineReservData
          .where((res) => res.clinicId.toString() == selectedClinic.value)
          .toList(),
    );
  }

  // The rest of the methods remain largely the same, but they will now
  // use the dynamic `reservationLimit` getter.

  List<Widget> buildCalendarDays(BuildContext context) {
    final days = <Widget>[];
    final year = currentDate.value.year;
    final month = currentDate.value.month;
    final today = DateTime.now();

    final firstDayOfMonth = DateTime(year, month, 1);
    final lastDayOfMonth = DateTime(year, month + 1, 0);

    int startWeekday = firstDayOfMonth.weekday % 7;

    for (int i = 0; i < startWeekday; i++) {
      days.add(const SizedBox.shrink());
    }

    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      final date = DateTime(year, month, day);
      // Now using the dynamic getter for the limit
      final isReserved = countReservationsForDate(date) >= reservationLimit;
      final isFriday = date.weekday == DateTime.friday;
      final isPast = date.isBefore(
        DateTime(today.year, today.month, today.day),
      );

      final isSelected =
          selectedDate.value != null &&
          date.day == selectedDate.value!.day &&
          date.month == selectedDate.value!.month &&
          date.year == selectedDate.value!.year;

      days.add(
        GestureDetector(
          onTap: (isReserved || isFriday || isPast)
              ? null
              : () => handleReserveClick(date, context),
          child: Container(
            decoration: BoxDecoration(
              color: isFriday
                  ? Colors.grey.shade300
                  : isPast
                  ? Colors.grey.shade200
                  : isReserved
                  ? Colors.red.shade200
                  : (isSelected ? Colors.indigo.shade200 : Colors.grey.shade50),
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? Border.all(color: Colors.indigo, width: 2)
                  : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(4.0),
            child: FittedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('d\nMMM').format(date),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isFriday || isPast
                          ? Colors.grey
                          : isReserved
                          ? Colors.grey.shade600
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  if (isReserved && !isPast)
                    FittedBox(
                      child: Text(
                        'Reserved'.tr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return days;
  }

  int countReservationsForDate(DateTime date) {
    final dateStr = DateFormat('yyyy-MM-dd').format(date);
    return onlineReservations
        .where(
          (res) =>
              res.dateTime == dateStr &&
              res.clinicId.toString() == selectedClinic.value,
        )
        .length;
  }

  void handleReserveClick(DateTime date, BuildContext context) {
    final reservationCount = countReservationsForDate(date);
    // Now using the dynamic getter for the limit
    if (reservationCount >= reservationLimit) {
      showAlertDialog(
        context,
        'Fully Reserved'.tr,
        'This date is already fully reserved!'.tr,
      );
      return;
    }
    selectedDate.value = date;
    dateController.text = DateFormat('yyyy-MM-dd').format(date);
  }

  void submitReservation() {
    if (selectedDate.value == null) {
      Get.dialog(
        AlertDialog(
          content: Text(
            'Please select a date to reserve.'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          alignment: Alignment.center,
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Center(child: Text('OK'.tr)),
            ),
          ],
        ),
      );
      return;
    }
    if (nameKey.currentState!.validate() &&
        mobileKey.currentState!.validate() &&
        selectedDate.value != null) {
      final reservation = OnlineReservModel(
        name: nameController.text,
        mobile: mobileController.text,
        dateTime: dateController.text,
        clinicId: int.parse(selectedClinic.value),
        isScheduled: false,
      );
      clinicController.createOnlineReserv(reservation);
      nameController.clear();
      mobileController.clear();
      selectedDate.value = null;
      dateController.clear();
    }
    fetchReservations();
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(onPressed: () => Get.back(), child: Text('OK'.tr)),
          ],
        );
      },
    );
  }

  void nextMonth() {
    final now = DateTime.now();
    final maxDate = DateTime(now.year, now.month + 2, now.day);
    if (currentDate.value.isBefore(maxDate)) {
      currentDate.value = DateTime(
        currentDate.value.year,
        currentDate.value.month + 1,
      );
    }
  }

  void previousMonth() {
    final now = DateTime.now();
    final isPastMonth =
        currentDate.value.year < now.year ||
        (currentDate.value.year == now.year &&
            currentDate.value.month <= now.month);
    if (!isPastMonth) {
      currentDate.value = DateTime(
        currentDate.value.year,
        currentDate.value.month - 1,
      );
    }
  }
}
