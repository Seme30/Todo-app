final String tableTodos = 'todos';

class TodoFields {
  static final List<String> values = [
    /// Add all fields
    id, todoTitle, todoDeadline, todoCreatedDate, status
  ];

  static const String id = 'id';
  static const String todoTitle = 'todoTitle';
  static const String todoDeadline = 'todoDeadline';
  static const String todoCreatedDate = 'todoCreatedDate';
  static const String status = 'status';
}

class TodoModel {
  int? id;
  String? todoTitle;
  DateTime? todoDeadline;
  DateTime? todoCreatedDate;
  String? status;

  TodoModel(
      {required this.id,
      required this.todoTitle,
      required this.todoDeadline,
      required this.todoCreatedDate,
      required this.status});

  TodoModel copy(
          {int? id,
          String? todoTitle,
          DateTime? todoDeadline,
          DateTime? todoCreatedDate,
          String? status}) =>
      TodoModel(
        id: id ?? this.id,
        todoTitle: todoTitle ?? this.todoTitle,
        todoDeadline: todoDeadline ?? this.todoDeadline,
        todoCreatedDate: todoCreatedDate ?? this.todoCreatedDate,
        status: status ?? this.status,
      );

  // static TodoModel fromJson(Map<String, dynamic> json) {
  //   String key = json['todoDeadline'];
  //   String key2 = json['todoCreatedDate'];
  //   DateTime dateTime = DateTime.parse(key);
  //   DateTime dateTime2 = DateTime.parse(key2);
  //   return TodoModel(
  //       id: json['id'],
  //       todoTitle: json['todoTitle'],
  //       todoCreatedDate: dateTime2,
  //       todoDeadline: dateTime,
  //       status: json['status']);
  // }

  // Map<String, dynamic> toJson(TodoModel todo) => {
  //       TodoFields.id: todo.id,
  //       TodoFields.todoTitle: todo.todoTitle,
  //       TodoFields.todoCreatedDate: todo.todoCreatedDate.toString(),
  //       TodoFields.todoDeadline: todo.todoDeadline.toString(),
  //       TodoFields.status: todo.status
  //     };
}
