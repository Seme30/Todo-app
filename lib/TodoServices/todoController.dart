
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/TodoServices/todoModel.dart';
import 'package:todoapp/TodoServices/todoRepo.dart';

class TodoController extends GetxController {

  final TodoRepo todoRepo;

  late TodoModel _todoModel;
  TodoModel get todoModel => _todoModel;

  List<TodoModel> _todoList = [];
  List<TodoModel> get todoList => _todoList;

   List<TodoModel> _completedTodoList = [];
  List<TodoModel> get completedTodoList => _completedTodoList;

  List<TodoModel> _notcompletedTodoList = [];
  List<TodoModel> get notcompletedTodoList => _notcompletedTodoList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  TodoController({
    required this.todoRepo
  });

  Future<void> getTodoList() async {

    Response response = await todoRepo.getTodoList();
    if(response.statusCode==200){
      _todoList = [];
      final List<dynamic> todolist = response.body; 
      for (var element in todolist) { 
        _todoList.add(TodoModel.fromJson(element));
      }
      for (var element in _todoList) { 
        if(element.status=='completed'){
          _completedTodoList.add(element);
        } 
      }
       _isLoaded = true;
      update();
    } else if(response.statusCode==1){
    } 
    else{
      print("Got no todos");
    }
  }

  Future<void> createTodo(String todoTitle, String todoCreatedDate, String todoDeadline, String status) async {
    Map<String,dynamic> data = {
      'todoTitle': todoTitle,
      'todoCreatedDate': todoCreatedDate,
      'todoDeadline': todoDeadline,
      'status': status
    };
    Response response = await todoRepo.createTodo(data);
    print(response.statusCode);
    final todo = json.decode(response.body);
    print(todo);
    if(response.statusCode == 201){
      print('201');
      _todoModel = TodoModel.fromJson(todo);
    } else {
     GetSnackBar(title: "Todo List", message: "Todo Creation Failed",
      backgroundColor: Colors.redAccent,);
    }
  }

}