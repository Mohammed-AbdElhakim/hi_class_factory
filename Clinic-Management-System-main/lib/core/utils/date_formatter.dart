import 'package:intl/intl.dart';

class DateFormatter {
  static String formatToYMD(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatToReadable(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  static String formatToTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }
}
