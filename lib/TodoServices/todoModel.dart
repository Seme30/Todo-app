final String tableTodos = 'todos';

class TodoFields {
  static final List<String> values = [
    /// Add all fields
    id, todoTitle, todoDeadline, todoCreatedDate, status
  ];

  static final String id = '_id';
  static final String todoTitle = 'todoTitle';
  static final String todoDeadline = 'todoDeadline';
  static final String todoCreatedDate = 'todoCreatedDate';
  static final String status = 'status';
}

class TodoModel {
  int? id;
  String? todoTitle;
  String? todoDeadline;
  String? todoCreatedDate;
  String? status;

  TodoModel(
      {this.id,
      required this.todoTitle,
      required this.todoDeadline,
      required this.todoCreatedDate,
      required this.status});

  TodoModel copy(
          {int? id,
          String? todoTitle,
          String? todoDeadline,
          String? todoCreatedDate,
          String? status}) =>
      TodoModel(
        id: id ?? this.id,
        todoTitle: todoTitle ?? this.todoTitle,
        todoDeadline: todoDeadline ?? this.todoDeadline,
        todoCreatedDate: todoCreatedDate ?? this.todoCreatedDate,
        status: status ?? this.status,
      );

  static TodoModel fromJson(Map<String, dynamic> json) => TodoModel(
      id: json['id'],
      todoTitle: json['todoTitle'],
      todoCreatedDate: json['todoCreatedDate'],
      todoDeadline: json['todoDeadline'],
      status: json['status']);

  Map<String, dynamic> toJson(TodoModel todo) => {
        TodoFields.id: todo.id,
        TodoFields.todoTitle: todo.todoTitle,
        TodoFields.todoCreatedDate: todo.todoCreatedDate,
        TodoFields.todoDeadline: todo.todoDeadline,
        TodoFields.status: todo.status
      };
}
