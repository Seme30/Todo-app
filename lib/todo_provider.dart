import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/TodoServices/todoModel.dart';
import 'package:todoapp/constants/app_constants.dart';


class TodoProvider with ChangeNotifier {

   late TodoModel _todoModel;
  TodoModel get todoModel =>_todoModel;

   late List<TodoModel> _todoModelList;
  List<TodoModel> get todoModeList => _todoModelList;

   Future<Map<String, dynamic>> createTodo(String todoTitle, String todoDeadline, String  todoCreatedDate, String status ) async {

    final Map<String, dynamic> todo = {
      'todoTitle': todoTitle,
      'todoDeadline': todoDeadline,
      'todoCreatedDate': todoCreatedDate,
      'status':status
    };
    

    return await http
        .post(Uri.parse(AppConstants.TODO),
            body: json.encode(todo),
            headers: {'Content-Type': 'application/json',
            "Access-Control-Allow-Origin": "*"
            })
        .then(onValue)
        .catchError(onError);
  }

  notify() {
    notifyListeners();
  }

    Map<String, dynamic> onValue(http.Response response)  {

    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 201) {
      _todoModel = TodoModel.fromJson(responseData);
    } else {
      const GetSnackBar(title: "Todo List", message: "Todo Creation Failed",
      backgroundColor: Colors.redAccent,);
    }
    return responseData;
  }

  static Future<List<TodoModel>> getData() async {

    print("get Data");

    List<TodoModel>? todo = [];

    print("todo");

    final uri = Uri.parse(AppConstants.TODO);
    print("uri: "+uri.toString());

    http.Response response = await http.get(uri,
    headers: {'Content-type':'application/json'});

    print("status code: "+response.statusCode.toString());    
    
    if (response.statusCode == 200) {
      print('hello');
      final todoList = json.decode(response.body);

      for(var element in todoList){
        todo.add(TodoModel.fromJson(element));
      }

      print(todo[0].todoTitle);
      // notifyListeners();

    } else {
      // notifyListeners();
      print(response.body);
      const GetSnackBar(title: "Todo", message: "Failed to retrieve data", backgroundColor: Colors.redAccent,);
    }
    return todo;
  }

  static onError(error) {
    print('the error is ${error.detail}');
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
