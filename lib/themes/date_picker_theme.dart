import 'package:flutter/material.dart';
import 'package:new_halo_task/themes/themes.dart';

DatePickerThemeData datePickerTheme = DatePickerThemeData(
  backgroundColor: Colors.teal,
  rangeSelectionBackgroundColor: primaryColor,
  dayBackgroundColor: MaterialStateProperty.all(Colors.transparent),
  dayOverlayColor: MaterialStateProperty.all(primaryColor),
  headerBackgroundColor: Colors.white,
  headerForegroundColor: Colors.black,
  todayBackgroundColor: MaterialStateProperty.all(primaryColor),
  todayForegroundColor: MaterialStateProperty.all(Colors.white),
  
);