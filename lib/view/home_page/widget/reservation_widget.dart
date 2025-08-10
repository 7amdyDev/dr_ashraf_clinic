import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/model/online_reserv_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/label_text_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/page_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// This is a mock for your Firebase data. In a real app, you would
// fetch this data from your Firebase Realtime Database.

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  var size = HelperFunctions.screenSize();
  TextEditingController dateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  var nameKey = GlobalKey<FormState>();
  var mobileKey = GlobalKey<FormState>();
  var dateKey = GlobalKey<FormState>();
  DateTime _currentDate = DateTime.now();
  String _selectedClinic = '1'; // Default to 'smouha'
  int selectedBranch = 1;
  List<OnlineReservModel> _reservations = [];
  final int _reservationLimit = 2; // Maximum reservations per day
  var controller = Get.put(ClinicController());

  // New state variable to track the currently selected date.
  DateTime? _selectedDate;

  // This method fetches data based on the selected place.
  // In a real app, this would be your Firebase integration logic.
  void _fetchReservations() {
    controller.getOnlineReservationData();
    setState(() {
      _reservations = controller.onlineReservData
          .where((res) => res.clinicId == int.parse(_selectedClinic))
          .toList();
    });
  }

  // Fetch reservations when the widget initializes or when the place changes.
  @override
  void initState() {
    super.initState();
    // After fetching data, we can initialize the reservations.
    _fetchReservations();

    // Initialize the selected date to today when the app starts.
    _selectedDate = null;
  }

  // A method to build the calendar grid for the current month.
  List<Widget> _buildCalendarDays() {
    final List<Widget> days = [];
    final year = _currentDate.year;
    final month = _currentDate.month;
    final today = DateTime.now();

    // Get the first day of the month
    final firstDayOfMonth = DateTime(year, month, 1);
    // Get the last day of the month
    final lastDayOfMonth = DateTime(year, month + 1, 0);

    // Find the weekday of the first day (1 = Monday, 7 = Sunday)
    int startWeekday = firstDayOfMonth.weekday % 7; // 0 = Sunday, 6 = Saturday

    // Pad the grid so the first day starts at the correct weekday
    for (int i = 0; i < startWeekday; i++) {
      days.add(const SizedBox.shrink());
    }

    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      final date = DateTime(year, month, day);
      final isReserved = _countReservationsForDate(date) >= _reservationLimit;
      final isFriday = date.weekday == DateTime.friday;
      // Check if the date is before today
      final isPast = date.isBefore(
        DateTime(today.year, today.month, today.day),
      );
      // Check if this date is the selected date
      final isSelected =
          _selectedDate != null &&
          date.day == _selectedDate!.day &&
          date.month == _selectedDate!.month &&
          date.year == _selectedDate!.year;

      days.add(
        GestureDetector(
          // Disable onTap for reserved days, Fridays, and past days
          onTap: (isReserved || isFriday || isPast)
              ? null
              : () => _handleReserveClick(date),
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('d MMM').format(date),
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
                const SizedBox(height: 4),
                if (isReserved)
                  const Text(
                    'Reserved',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                // else if (!isFriday && !isPast)
                //   Text(
                //     '${_countReservationsForDate(date)}/$_reservationLimit',
                //     style: TextStyle(
                //       fontSize: 10,
                //       color: Colors.indigo.shade700,
                //       fontWeight: FontWeight.w600,
                //     ),
                //   ),
              ],
            ),
          ),
        ),
      );
    }
    return days;
  }

  // Counts the number of reservations for a specific date and selected place.
  int _countReservationsForDate(DateTime date) {
    final dateStr = DateFormat('yyyy-MM-dd').format(date);
    // Filter reservations by both date and selected clinicId
    return _reservations
        .where(
          (res) =>
              res.dateTime == dateStr &&
              res.clinicId == int.parse(_selectedClinic),
        )
        .length;
  }

  // Simulates a new reservation when a day is tapped.
  void _handleReserveClick(DateTime date) {
    final reservationCount = _countReservationsForDate(date);
    if (reservationCount >= _reservationLimit) {
      // In Flutter web, we can't use `alert()`. We use a custom dialog instead.
      _showAlertDialog(
        'Fully Reserved',
        'This date is already fully reserved!',
      );
      return;
    }

    // Update the selected date and rebuild the UI
    setState(() {
      _selectedDate = date;
      dateController.text = DateFormat('yyyy-MM-dd').format(date);
    });
  }

  // Shows a custom alert dialog instead of using `alert()`.
  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    // Check if the current calendar month is in the past compared to today.
    final isPastMonth =
        _currentDate.year < now.year ||
        (_currentDate.year == now.year && _currentDate.month <= now.month);

    // Check if the current month is at or beyond the 3-month forward limit.
    final maxDate = DateTime(now.year, now.month + 2, now.day);
    final isMaxMonth = _currentDate.isAfter(maxDate);

    return SizedBox(
      width: size.width * 0.85,
      //  height: 1050,
      child: Column(
        children: [
          const PageTitleWidget(text: 'book_sheet_label'),
          const SizedBox(height: HSizes.spaceBtwSections),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Colors.indigo,
                    size: 36,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('MMMM yyyy').format(_currentDate),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Select a clinic branch and a date to reserve.'.tr,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: isPastMonth
                        ? null
                        : () {
                            setState(() {
                              _currentDate = DateTime(
                                _currentDate.year,
                                _currentDate.month - 1,
                              );
                            });
                          },
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: isMaxMonth
                        ? null
                        : () {
                            setState(() {
                              _currentDate = DateTime(
                                _currentDate.year,
                                _currentDate.month + 1,
                              );
                            });
                          },
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),
          // Calendar Grid
          Expanded(
            child: Column(
              children: [
                // Weekday headers
                GridView.count(
                  crossAxisCount: 7,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                      .map(
                        (day) => Center(
                          child: Text(
                            day,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 8),
                // Days of the month
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 7,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    children: _buildCalendarDays(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LabelTextWidget(text: 'clinic_branch_label'),
                          SizedBox(height: HSizes.spaceBtwSections),
                          LabelTextWidget(text: 'name_label'),
                          SizedBox(height: HSizes.spaceBtwSections),
                          LabelTextWidget(text: 'mobile_label'),
                          SizedBox(height: HSizes.spaceBtwSections),
                        ],
                      ),
                    ),

                    FittedBox(
                      child: Column(
                        children: [
                          SizedBox(
                            width: size.width / 2,
                            child: DropdownButtonFormField<String>(
                              value: _selectedClinic,
                              decoration: InputDecoration(
                                labelText: 'clinic_branch_label'.tr,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: '1',
                                  child: Text('عيادة سموحة'.tr),
                                ),
                                DropdownMenuItem(
                                  value: '2',
                                  child: Text('عيادة العجمي'.tr),
                                ),
                              ],
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _selectedClinic = newValue;
                                    _selectedDate = null;

                                    // The `_fetchReservations()` call is correct here.
                                    // It will update the local list based on the new place.
                                    _fetchReservations();
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: HSizes.spaceBtwItems),
                          SizedBox(
                            width: size.width / 2,
                            child: Form(
                              key: nameKey,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: HValidator.validateText,
                                textAlign: TextAlign.center,
                                controller: nameController,
                              ),
                            ),
                          ),
                          const SizedBox(height: HSizes.spaceBtwItems),
                          SizedBox(
                            width: size.width / 2,
                            child: Form(
                              key: mobileKey,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: HValidator.validateText,
                                controller: mobileController,
                              ),
                            ),
                          ),

                          const SizedBox(height: HSizes.spaceBtwItems),
                        ],
                      ),
                    ),
                    const SizedBox(width: HSizes.spaceBtwSections),
                  ],
                ),
                HFilledButton(
                  text: 'save_button',
                  onPressed: () {
                    if (nameKey.currentState!.validate() &&
                        mobileKey.currentState!.validate() &&
                        _selectedDate != null) {
                      var reservation = OnlineReservModel(
                        name: nameController.text,
                        mobile: mobileController.text,
                        dateTime: dateController.text,
                        clinicId: int.parse(_selectedClinic),
                      );

                      controller.createOnlineReserv(reservation);

                      // _selectedDate = null; // Reset the selected date
                      // Refresh the reservations list
                      // Get.back();
                    }
                  },
                ),
              ],
            ),
          ),
          // Calendar Header
          const SizedBox(height: HSizes.spaceBtwSections),
        ],
      ),
    );
  }
}
