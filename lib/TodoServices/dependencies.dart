
import 'package:get/get.dart';
import 'package:todoapp/TodoServices/ApiClient.dart';
import 'package:todoapp/TodoServices/todoController.dart';
import 'package:todoapp/TodoServices/todoRepo.dart';
import 'package:todoapp/constants/app_constants.dart';

Future<void> init() async{

  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repos
  Get.lazyPut(() => TodoRepo(apiClient: Get.find()));

  //controller
  Get.lazyPut(() => TodoController(todoRepo: Get.find()));
  
}