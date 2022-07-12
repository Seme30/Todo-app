
enum Status{
    completed,
    notCompleted
  }

class TodoModel {
  int? id;
  String? todoTitle;
  DateTime? todoDeadline;
  DateTime? todoCreatedDate;
  Status? status;

   TodoModel({
    required this.id,
    required this.todoTitle,
    required this.todoDeadline,
    required this.todoCreatedDate,
    required this.status
  });

  TodoModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    todoTitle = json['todoTitle'];
    todoCreatedDate = json['todoCreatedDate'];
    todoDeadline = json['todoDeadline'];
    status = json['status'];
  }

}



