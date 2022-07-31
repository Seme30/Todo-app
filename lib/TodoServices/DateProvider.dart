import 'package:flutter/material.dart';

class DateProvider with ChangeNotifier {
  Map<int, DateTime> _dateTime = {};
  Map<int, DateTime> get dateTime => _dateTime;

  DateTime _date = DateTime.now();
  DateTime get date => _date;

  void setDate(int id, DateTime date) {
    _dateTime.addAll({id: date});
    setDate2(date);
    notifyListeners();
  }

  void setDate2(DateTime date) {
    _date = date;
  }
}
