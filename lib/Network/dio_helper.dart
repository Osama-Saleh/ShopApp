// ignore_for_file: unnecessary_null_in_if_null_operators

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio = Dio();

  static Init() {
    dio = Dio(BaseOptions(
      baseUrl: "https://student.valuxapps.com/api/",
      receiveDataWhenStatusError: true,
      // headers: {"Content-Type": "application/json"}
    ));
  }

  static Future<Response> getData(
      {@required String? url,
      String? token,
      String? lang = "en",
      Map<String, dynamic>? query}) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": token
    };
    return await dio.get(url!);
  }

  static Future<Response> postData({
    @required String? url,
    @required Map<String, dynamic>? data,
    String? token,
    String? lang = "en",
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": token
    };
    return await dio.post(url!, data: data);
  }

  static Future<Response> putUpdateData({
    @required String? url,
    @required Map<String, dynamic>? data,
    @required String? token,
    // String? lang = "ar",
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      // "lang": lang,
      "Authorization": token
    };
    return await dio.put(url!, data: data);
  }
}
