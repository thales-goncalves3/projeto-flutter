import 'package:intl/intl.dart';

class ConvertDate {
  static String toDate(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);
    return date;
  }
}
