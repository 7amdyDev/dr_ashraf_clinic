import 'package:dr_ashraf_clinic/controller/appointment_controller.dart';
import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/online_reservation_table.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/schedule_table_widget.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/page_label_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReceptionSchedulePage extends StatelessWidget {
  const ReceptionSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ClinicController());
    var appointmentController = Get.put(AppointmentController());
    return Column(
      children: [
        const SizedBox(
          height: HSizes.spaceBtwItems,
        ),
        const PageLabelWidget(
          text: 'schedule_table_label',
        ),
        const SizedBox(
          height: HSizes.spaceBtwSections,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HFilledButton(
                text: 'today_label'.tr,
                onPressed: () {
                  appointmentController.getAppointsByDate();
                }),
            HFilledButton(
                text: 'choose_date_label'.tr,
                onPressed: () {
                  datePickerDialog(context, appointmentController);
                }),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: HSizes.spaceBtwItems,
                ),
                HScheduleDataTable(
                    searchResult: appointmentController.appointListByDate),
                const PageLabelWidget(
                  text: 'online_table_label',
                ),
                HOnlineReservationTable(
                    onlineReserv: controller.onlineReservData)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void datePickerDialog(context, AppointmentController controller) {
  final Future<DateTime?> picked = showDatePicker(
    context: context,
    //s  selectableDayPredicate: (DateTime val) => val.weekday == 5 ? false : true,
    currentDate: DateTime.now(),
    initialDate: DateTime.now(),
    firstDate: DateTime(2024),
    lastDate: DateTime.now().add(const Duration(days: 90)),
    builder: (context, child) {
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: HColors.primary,
            onPrimary: Colors.white,
            surface: HColors.secondary,
            onSurface: HColors.black,
          ),
          dialogBackgroundColor: Colors.blue[900],
        ),
        child: child!,
      );
    },
  );
  picked.then((onValue) {
    controller.getAppointsByDate(date: HFormatter.formatDate(onValue));
    // dateController.text = HFormatter.formatDate(onValue);
  });
}
