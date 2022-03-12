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
  final DateTime date;
  final repeat taskRepeat;
  final tasktype taskType;

  const Task({
    required this.id,
    required this.taskName,
    required this.date,
    required this.taskRepeat,
    required this.taskType,
  });
}
