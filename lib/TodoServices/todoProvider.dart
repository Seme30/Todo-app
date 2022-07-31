import 'package:flutter/material.dart';
import 'package:todoapp/TodoServices/todoModel.dart';
import 'package:todoapp/TodoServices/todoDatabase.dart';

class TodoProvider with ChangeNotifier {
  bool isLoading = true;
  late TodoModel _todo;
  List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;

  TodoModel getTodo(int id) {
    return _todos.firstWhere((element) => element.id == id);
  }

  void setTodo(TodoModel todo) {
    _todo = todo;
    _todos.add(todo);
    isLoading = false;
    notifyListeners();
  }

  void setTodos(List<TodoModel> todos) {
    _todos = todos;
    isLoading = false;
    notifyListeners();
  }
}
