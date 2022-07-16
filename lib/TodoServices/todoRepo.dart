
import 'package:get/get.dart';
import 'package:todoapp/TodoServices/ApiClient.dart';
import 'package:todoapp/constants/app_constants.dart';

class TodoRepo extends GetxService{
  final ApiClient apiClient;

  TodoRepo({
    required this.apiClient
  });

  Future<Response> getTodoList() async {
    print('todo repo');
    return await apiClient.getTodos(AppConstants.TODO);
  }


}