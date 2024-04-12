import 'package:dio/dio.dart';
//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca
//https://www.newsmisr.info/wp-content/uploads/2022/08/حديد-تسليح.jpg
//77b7c9627b664aa9b81ee875eafaf5ec key al api bta3y
//https://newsapi.org/v2/everything?q=tesla&apiKey=65f7f556ec76449fa7dc7c0069f040ca
class DioHelper {
  static late Dio dio ;
  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl:'https://newsapi.org/',
        receiveDataWhenStatusError: true
      )
    );
  }


  static Future<Response> getData({required String url, required Map<String, dynamic> query }) async{
    return await dio.get(url,queryParameters: query );
  }

}