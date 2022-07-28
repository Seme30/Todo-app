import 'package:flutter/material.dart';
import 'package:todoapp/TodoServices/todoModel.dart';
import 'package:todoapp/TodoServices/todoDatabase.dart';

class TodoProvider with ChangeNotifier {
  bool isLoading = true;
  late TodoModel _todo;
  TodoModel get todo => _todo;
  List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;
  final database = TodoDatabase.instance;

  Future<void> readTodos() async {
    _todos = [];
    _todos = await database.readAllTodos();
    isLoading = false;
    notifyListeners();
  }

  Future<void> readTodo(int id) async {
    _todo = await database.readTodo(id);
    isLoading = false;
    notifyListeners();
  }

  Future<void> createTodos(TodoModel todo) async {
    TodoModel toodo = await database.create(todo);
    _todos.add(toodo);
    notifyListeners();
  }
}
