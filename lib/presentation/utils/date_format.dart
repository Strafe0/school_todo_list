import 'package:intl/intl.dart';
import 'package:flutter/material.dart' show Locale;

String convertDateTimeToString(DateTime dateTime, Locale locale) {
  if (locale.languageCode == 'en') {
    return DateFormat.yMMMMd().format(dateTime);
  }
  return DateFormat('d MMMM y', locale.languageCode).format(dateTime);
}
