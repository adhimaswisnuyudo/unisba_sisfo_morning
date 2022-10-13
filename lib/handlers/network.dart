import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unisba_sisfo/config/constanta.dart' as cs;

class DioRequest {
  static Dio dio = Dio();

  Future<dynamic> login(FormData data) async {
    dio.options.headers['content-Type'] = 'application/json';
    final response = await dio.post(cs.loginUrl, data: data);
    if (response.statusCode != 200) {
      return response.statusCode;
    } else {
      return response.data;
    }
  }

  Future<dynamic> post(String url, Map<String, dynamic> header,
      Map<String, dynamic> data) async {
    dio.options.headers['content-Type'] = 'application/json';
    // dio.options.headers["Authorization"] = "Bearer $token";
    final response = await dio.post(url, data: data);
    if (response.statusCode != 200) {
      return response.statusCode;
    } else {
      return response.data;
    }
  }

  Future<dynamic> get(String url, Map<String, dynamic> header) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      // dio.options.headers["Authorization"] = "Bearer $token";

      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return response;
      } else {
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
