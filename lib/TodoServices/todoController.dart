
import 'package:get/get.dart';
import 'package:todoapp/TodoServices/todoModel.dart';
import 'package:todoapp/TodoServices/todoRepo.dart';

class TodoController extends GetxController {

  final TodoRepo todoRepo;

  List<TodoModel> _todoList = [];
  List<TodoModel> get todoList => _todoList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  TodoController({
    required this.todoRepo
  });

  Future<void> getTodoList() async {
    print('getList called todo controller');
    Response response = await todoRepo.getTodoList();
    print('response body from todo controller: ');
    if(response.statusCode==200){
      print("Got Todos");
      _todoList = [];
      final List<dynamic> todolist = response.body; 
      for (var element in todolist) { 
        _todoList.add(TodoModel.fromJson(element));
      }
       _isLoaded = true;
      update();
    } else if(response.statusCode==1){
      print(response.statusText);
    } 
    else{
      print("Got no todos");
    }
  }

}