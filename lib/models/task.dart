
enum Status{
    completed,
    notCompleted
  }


class Todo {
  final String id;
  final String taskName;
  final DateTime deadline;
  final DateTime createdDate;
  final Status status;

  const Todo({
    required this.id,
    required this.taskName,
    required this.deadline,
    required this.createdDate,
    required this.status
  });
}
