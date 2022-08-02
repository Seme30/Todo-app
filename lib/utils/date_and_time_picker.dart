import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  late DateTime dateTime;
  bool showDate = false;
  bool showTime = false;
  bool showDateTime = false;

  // Select for Date
  Future<DateTime> selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      selectedDate = selected;
    }
    return selectedDate;
  }

// Select for Time
  Future<TimeOfDay> selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      selectedTime = selected;
    }
    return selectedTime;
  }
  // select date time picker

  Future selectDateTime(BuildContext context) async {
    final date = await selectDate(context);
    // ignore: unnecessary_null_comparison
    if (date == null) return;

    final time = await selectTime(context);

    // ignore: unnecessary_null_comparison
    if (time == null) return;
    dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    // await notificationService.createTodoReminderNotification(dateTime, title);
  }

  String getDate() {
    // ignore: unnecessary_null_comparison
    if (selectedDate == null) {
      return 'select date';
    } else {
      return DateFormat('yyyy-MM-dd').format(selectedDate);
    }
  }

  // DateTime getDateTime2() {
  //   // ignore: unnecessary_null_comparison
  //   if (dateTime == null) {
  //     return DateTime.now().subtract(Duration(days: 2));
  //   } else {
  //     return dateTime;
  //   }
  // }

  DateTime getDateTime() {
    return dateTime;
  }
}
