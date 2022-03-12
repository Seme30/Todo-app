import './models/task.dart';
import 'package:flutter/foundation.dart';

final _localData = [
  Task(
    id: 't1',
    taskName: 'Pay Bills',
    date: DateTime.now(),
    taskRepeat: repeat.onceinmonth,
    taskType: tasktype.personal,
  ),
  Task(
    id: 't2',
    taskName: 'Call Someone',
    date: DateTime.now(),
    taskRepeat: repeat.onceinmonth,
    taskType: tasktype.personal,
  ),
  Task(
    id: 't3',
    taskName: 'Go to Doctor',
    date: DateTime.now(),
    taskRepeat: repeat.twiceinmonth,
    taskType: tasktype.personal,
  ),
];

List<Task> get getLocalData {
  return ([..._localData]);
}
