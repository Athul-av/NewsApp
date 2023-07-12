
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:newsapp/apiconstant.dart';
import 'package:newsapp/model/newsmodel.dart';

class ApiService{

  Dio dio = Dio();

  Future<News?> getdata()async{

    try {
      Response res = await dio.get(ApiConstant.api);

      if (res.statusCode == 200 || res.statusCode == 201) {
      final Map<String,dynamic>  json = res.data;
  
        return News.fromJson({'articles':json['articles']});
      }
    } catch (e) {
      log(e.toString()); 
    }
    return null;
  }
}