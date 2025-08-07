import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ricky_and_martie_app/config/environments.dart';

class DioConfig {
  static Dio createDio({String? baseUrl}) {
    final finalBaseUrl = baseUrl ?? Environments.baseUrl;

    final dio = Dio();

    dio.options.baseUrl = finalBaseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // dio.interceptors.add(LogInterceptor(
    //   requestBody: true,
    //   responseBody: true,
    //   // logPrint: (obj) => debugPrint(obj.toString()),
    // ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Aqui adicionaria headers de autenticação se necessário
        handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (error, handler) {
        debugPrint('Erro na requisição: ${error.message}');
        handler.next(error);
      },
    ));

    return dio;
  }
}
