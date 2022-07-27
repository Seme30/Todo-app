import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todoapp/TodoServices/todoModel.dart';
import 'dart:convert';

class StorageService {
  final storage = FlutterSecureStorage();

  List<TodoModel> _listofTodos = [];
  // List<TodoModel> get listofTodos => _listofTodos;

  // Map<String, dynamic> todo = {};

  // List<Map<String, dynamic>> todosMap = [];

  void writeTodos(List<TodoModel> todos) async {
    List<Map<String, dynamic>> todosMap = [];
    for (var element in todos) {
      todosMap.add({
        "id": element.id,
        "todoTitle": element.todoTitle,
        "todoCreatedDate": element.todoCreatedDate,
        "todoDeadline": element.todoDeadline,
        "status": element.status
      });
    }
    await storage.write(key: 'listoftodos', value: jsonEncode(todosMap));
  }

  Future<void> writeTodo(Map<String, dynamic> todo) async {
    await storage.write(key: 'todo', value: jsonEncode(todo));
  }

  Future<List<TodoModel>> getTodos() async {
    List<Map<String, dynamic>> todosMap = [];
    String? stringoftodos = await storage.read(key: 'listoftodos');
    todosMap = jsonDecode(stringoftodos!);
    _listofTodos = [];
    for (var element in todosMap) {
      _listofTodos.add(TodoModel.fromJson(element));
    }
    return _listofTodos;
  }
}
