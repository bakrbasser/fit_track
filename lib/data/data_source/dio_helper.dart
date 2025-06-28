import 'package:dio/dio.dart';
import 'package:fit_track/core/api_consts.dart';

class DioClient {
  static final Dio _dio = Dio();

  static Dio get dio {
    _dio.options.baseUrl = ApiConsts.baseUrl;
    _dio.interceptors.add(LogInterceptor()); // Global logging
    return _dio;
  }
}
