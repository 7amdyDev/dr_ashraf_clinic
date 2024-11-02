import 'dart:math';

import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HelperFunctions {
  static Color? getColor(String value) {
    /// Define your product specific colors here and it will match the attribute colors and show specific 🟠🟡🟢🔵🟣🟤

    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.deepOrange;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Teal') {
      return Colors.teal;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else {
      return null;
    }
  }

  // static void showSnackBar(String message) {
  //   ScaffoldMessenger.of(Get.context!).showSnackBar(
  //     SnackBar(content: Text(message)),
  //   );
  // }

  static bool isLocalEnglish() {
    return Get.locale == const Locale('en', 'US');
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.sizeOf(Get.context!).width;
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }

  static double clinicPagesWidth() {
    double width = HelperFunctions.screenWidth() <=
            HSizes.maxPageWidth - (HelperFunctions.screenWidth() * 0.2)
        ? HelperFunctions.screenWidth()
        : HSizes.maxPageWidth - 450;
    return width;
  }

  static double drawerWidth() {
    double drawerWidth = clinicPagesWidth() <= HSizes.maxPageWidth
        ? clinicPagesWidth() * 0.20
        : 450;
    return drawerWidth;
  }

  static showSnackBar(String message) {
    Get.snackbar(
      message,
      '',
      shouldIconPulse: true,
      icon: const Icon(
        Icons.check,
        color: Colors.white,
        size: 32,
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: HColors.primary,
      borderRadius: 20,
      maxWidth: 500,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static List<Color> generateBarColors(int count) {
    final List<Color> colors = [];
    final Random random = Random();
    for (int i = 0; i < count; i++) {
      // Generate a distinct hue
      double hue = (i * (360 / count)) % 360; // Evenly spaced hues
      double saturation =
          0.7 + random.nextDouble() * 0.3; // Saturation between 0.7 and 1.0
      double lightness =
          0.5 + random.nextDouble() * 0.3; // Lightness between 0.5 and 0.8

      // Convert HSL to RGB
      Color color =
          HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
      colors.add(color);
    }

    return colors;
  }
}
