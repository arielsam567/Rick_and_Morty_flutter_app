import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ricky_and_martie_app/config/environments.dart';

class DioConfig {
  static Dio createDio({String? baseUrl}) {
    // URL base obtida do arquivo de ambientes
    // Pode ser sobrescrita através de parâmetros de linha de comando
    final finalBaseUrl = baseUrl ?? Environments.baseUrl;

    final dio = Dio();

    // Configuração base
    dio.options.baseUrl = finalBaseUrl;
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
