enum repeat {
  onceinmonth,
  twiceinmonth,
  threetimes,
}

enum tasktype {
  personal,
  organizational,
}

class Task {
  final String id;
  final String taskName;
  final DateTime dueDate;
  final repeat taskRepeat;
  final tasktype taskType;

  Task({
    required this.id,
    required this.taskName,
    required this.dueDate,
    required this.taskRepeat,
    required this.taskType,
  });
}
