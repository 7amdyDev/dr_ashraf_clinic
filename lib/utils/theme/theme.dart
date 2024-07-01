import '/../utils/theme/custom_themes/appbar_theme.dart';
import '/../utils/theme/custom_themes/bottom_sheet_theme.dart';
import '/../utils/theme/custom_themes/checkbox_theme.dart';
import '/../utils/theme/custom_themes/chip_theme.dart';
import '/../utils/theme/custom_themes/elevated_button_theme.dart';
import '/../utils/theme/custom_themes/outlined_button_theme.dart';
import '/../utils/theme/custom_themes/text_field_theme.dart';
import '/../utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class HAppTheme {
  HAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: HColors.grey,
    brightness: Brightness.light,
    primaryColor: HColors.primary,
    textTheme: HTextTheme.lightTextTheme,
    chipTheme: HChipTheme.lightChipTheme,
    scaffoldBackgroundColor: HColors.white,
    appBarTheme: HAppBarTheme.lightAppBarTheme,
    checkboxTheme: HCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: HBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: HElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: HOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: HTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: HColors.grey,
    brightness: Brightness.dark,
    primaryColor: HColors.primary,
    textTheme: HTextTheme.darkTextTheme,
    chipTheme: HChipTheme.darkChipTheme,
    scaffoldBackgroundColor: HColors.black,
    appBarTheme: HAppBarTheme.darkAppBarTheme,
    checkboxTheme: HCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: HBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: HElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: HOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: HTextFormFieldTheme.darkInputDecorationTheme,
  );
}
