import 'dart:io';
import 'dart:convert';

import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  
  final String appBaseUrl;

  late Map<String,String> _mainHeaders;

  ApiClient({required this.appBaseUrl}){
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    _mainHeaders = {'Content-type': 'application/json',"Access-Control-Allow-Origin": "*"};

  }
      
  Future<Response> getTodos(String uri) async{
    print('called api client');
    try{
      print('url');
      Response response = await get(uri);
      print(response.statusCode);
      print('got response in api client');
      return response;
    }catch(e){
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  
}