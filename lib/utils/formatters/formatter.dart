import 'package:intl/intl.dart';

class HFormatter {
  static String formatDate(DateTime? date, {bool reversed = false}) {
    date ??= DateTime.now();
    if (reversed) {
      return DateFormat('yyyy-MM-dd').format(date);
    } else {
      return DateFormat('dd-MM-yyyy')
          .format(date); // Customize the date format as needed
    }
  }

  static String formatStringDate(String mysqlDateString,
      {bool reversed = false}) {
    DateTime dateTime = DateTime.parse(mysqlDateString);
    DateFormat formatter;
    dateTime = dateTime
        .add(const Duration(hours: 4)); // to get the difference in time zone
    if (reversed) {
      formatter = DateFormat('yyyy-MM-dd');
    } else {
      formatter = DateFormat('dd-MM-yyyy');
      // Customize the date format as needed
    }

    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  static int countDuration(String duration) {
    var list = duration.split(':');
    var callDuration = Duration(
        hours: int.parse(list[0]),
        minutes: int.parse(list[1]),
        seconds: int.parse(list[2]));
    return (callDuration.inSeconds / 60).ceil();
  }

  // Split text into list of Strings
  static List splitTextIntoList(String data) {
    // Split text into list of Strings
    var list = data.split(" ");
    // Split every call line to List of Strings
    var cdrLine = [];
    for (var element in list) {
      if (element.isNotEmpty) {
        cdrLine.add(element);
      }
    }
    return cdrLine;
  }

  // coordinate recived data and split into lines
  static String coordinateRecievedData(String recievedData) {
    var result = recievedData;

    // choose only the correct lines and make data ready for spliting the lines
    if (recievedData.length == 72) {
      String data = recievedData.replaceAll(RegExp(r': '), ':0');
      data = data.replaceAll(RegExp(r'\. '), '.0');
      data = data.replaceAll(RegExp(r'\.'), '-');
      result = data;
    }

    return result;
  }

  static String reverseFormatDate(String date) {
    DateTime dateTime = DateFormat("dd-MM-yyyy").parse(date);
    DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = outputFormat.format(dateTime);
    return formattedDate;
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$')
        .format(amount); // Customize the currency locale and symbol as needed
  }

  static String formatPhoneNumber(String phoneNumber) {
    // Assuming a 10-digit US phone number format: (123) 456-7890
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    }
    // Add more custom phone number formatting logic for different formats if needed.
    return phoneNumber;
  }

  // Not fully tested.
  static String internationalFormatPhoneNumber(String phoneNumber) {
    // Remove any non-digit characters from the phone number
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Extract the country code from the digitsOnly
    String countryCode = '+${digitsOnly.substring(0, 2)}';
    digitsOnly = digitsOnly.substring(2);

    // Add the remaining digits with proper formatting
    final formattedNumber = StringBuffer();
    formattedNumber.write('($countryCode) ');

    int i = 0;
    while (i < digitsOnly.length) {
      int groupLength = 2;
      if (i == 0 && countryCode == '+1') {
        groupLength = 3;
      }

      int end = i + groupLength;
      formattedNumber.write(digitsOnly.substring(i, end));

      if (end < digitsOnly.length) {
        formattedNumber.write(' ');
      }
      i = end;
    }

    return formattedNumber.toString();
  }

  static String convertArabicToEnglishNumbers(String input) {
    const numberMap = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };

    return input.replaceAllMapped(RegExp(r'[٠-٩]'),
        (match) => numberMap[match.group(0)] ?? match.group(0)!);
  }
}


/*
*
*
* */
