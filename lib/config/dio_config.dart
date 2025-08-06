import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioConfig {
  static Dio createDio() {
    final dio = Dio();

    // Configuração base
    dio.options.baseUrl = 'https://rickandmortyapi.com/api/';
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Interceptors
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => debugPrint(obj.toString()),
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Aqui você pode adicionar headers de autenticação se necessário
        handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (error, handler) {
        // Tratamento de erro global
        debugPrint('Erro na requisição: ${error.message}');
        handler.next(error);
      },
    ));

    return dio;
  }
}
