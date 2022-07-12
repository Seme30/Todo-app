

import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  
  final String appBaseUrl;

  late Map<String,String> _mainHeaders;

  ApiClient({required this.appBaseUrl}){
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    _mainHeaders = {
      'Content-type':'application/json; charset=UTF-8',
    };
  }

  Future<Response> getTodos(String url) async{
    try{
      Response response = await get(url);
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
  
}