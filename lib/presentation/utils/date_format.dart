import 'package:intl/intl.dart';

String convertDateTimeToString(DateTime dateTime) {
  return DateFormat('d MMMM y', 'ru').format(dateTime);
}
