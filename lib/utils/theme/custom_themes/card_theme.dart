import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:flutter/material.dart';

final myCardTheme = CardThemeData(
  color: HColors.primaryBackground,
  elevation: 5.0,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  margin: const EdgeInsets.all(10.0),
  shadowColor: Colors.grey.withValues(alpha: 0.5),
  surfaceTintColor: HColors.lightGrey,
);
