import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:flutter/material.dart';

final myCardTheme = CardTheme(
  color: HColors.primaryBackground,
  elevation: 5.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
  ),
  margin: const EdgeInsets.all(10.0),
  shadowColor: Colors.grey.withOpacity(0.5),
  surfaceTintColor: HColors.lightGrey,
);
