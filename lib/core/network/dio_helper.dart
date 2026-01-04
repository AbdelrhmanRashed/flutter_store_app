import 'package:app3/core/network/end_points.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  //instance of dio
  static Dio? dio;

  //initialization
  static void initDio() {
    dio ??= Dio(
      BaseOptions(receiveDataWhenStatusError: true, baseUrl: EndPoints.baseUrl),
    );
    dio!.interceptors.add(PrettyDioLogger());
  }

  //methods
  static Future<Response> getRequest({required String endPoint}) async {
    try {
      final response = await dio!.get(endPoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> postRequest({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await dio!.post(endPoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
