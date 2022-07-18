import 'dart:io';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:todoapp/TodoServices/todoModel.dart';

class ApiClient extends GetConnect implements GetxService {
  
  final String appBaseUrl;

  late Map<String,String> _mainHeaders;

  ApiClient({required this.appBaseUrl}){
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    _mainHeaders = {'Content-type': 'application/json',"Access-Control-Allow-Origin": "*"};

  }
      
  Future<Response> getTodos(String uri) async{
    try{
      Response response = await get(uri);
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> createTodo(String url, dynamic json) async {
    try{
      Response response = await post(url,json);
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  
}