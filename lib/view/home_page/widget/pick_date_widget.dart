import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';

class PickDateWidget extends StatelessWidget {
  const PickDateWidget({
    super.key,
    required this.width,
    this.textFontSize = 18,
    required this.dateController,
    this.validator,
    this.firstDate,
    this.lastDate,
  });

  final double width;
  final double textFontSize;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final TextEditingController dateController;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    //  dateController.text = HFormatter.formatDate(DateTime.now());
    return SizedBox(
      width: width,
      child: TextFormField(
        validator: validator,
        style: TextStyle(fontSize: textFontSize),
        textAlign: TextAlign.center,
        controller: dateController,
        decoration: const InputDecoration(suffixIcon: Icon(Icons.date_range)),
        onTap: () {
          final Future<DateTime?> picked = showDatePicker(
            context: context,
            // selectableDayPredicate: (DateTime val) =>
            //     val.weekday == 5 ? false : true,
            currentDate: DateTime.now(),
            initialDate: DateTime.now(),
            firstDate:
                firstDate ?? DateTime.now().subtract(const Duration(days: 3)),
            lastDate: lastDate ?? DateTime.now().add(const Duration(days: 40)),
            builder: (context, child) {
              return Theme(
                data: ThemeData.dark().copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: HColors.primary,
                    onPrimary: Colors.white,
                    surface: HColors.secondary,
                    onSurface: HColors.black,
                  ),
                  dialogTheme:
                      DialogThemeData(backgroundColor: Colors.blue[900]),
                ),
                child: child!,
              );
            },
          );
          picked.then((onValue) {
            onValue ?? DateTime.now();
            dateController.text = HFormatter.formatDate(onValue);
          });
        },
      ),
    );
  }
}
