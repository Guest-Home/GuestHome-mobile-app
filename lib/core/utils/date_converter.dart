import 'package:intl/intl.dart';

class DateConverter{

  String formatDate(String dateStr) {
    // Parse the date string
    DateTime dateTime = DateTime.parse(dateStr);

    // Format the date to a full date and time format
    String formattedDate = DateFormat('EEEE').format(dateTime);

    return formattedDate;
  }
  String formatDateMonth(String dateStr) {
    // Parse the date string
    DateTime dateTime = DateTime.parse(dateStr);

    // Format the date to a full date and time format
    String formattedDate = DateFormat('MMMM d').format(dateTime);

    return formattedDate;
  }
  String formatDateTime(String dateStr) {
    // Parse the date string
    DateTime dateTime = DateTime.parse(dateStr);

    // Format the date to a full date and time format
    String formattedDate = DateFormat('y h:mm a').format(dateTime);

    return formattedDate;
  }

}