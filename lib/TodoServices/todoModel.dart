


class TodoModel {
  int? id;
  String? todoTitle;
  String? todoDeadline;
  String? todoCreatedDate;
  String? status;

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



