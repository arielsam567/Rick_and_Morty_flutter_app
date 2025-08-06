import 'package:dio/dio.dart';

/// Abstração simples para cliente HTTP
abstract class HttpClient {
  Future<HttpResponse> get(String path,
      {Map<String, dynamic>? queryParameters});
}

/// Resposta HTTP padronizada
class HttpResponse {
  final dynamic data;
  final int statusCode;

  HttpResponse({
    required this.data,
    required this.statusCode,
  });
}

/// Implementação do HttpClient usando Dio
class DioHttpClient implements HttpClient {
  final Dio _dio;

  DioHttpClient(this._dio);

  @override
  Future<HttpResponse> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return HttpResponse(
        data: response.data,
        statusCode: response.statusCode ?? 200,
      );
    } on DioException catch (e) {
      throw Exception('Erro na requisição: ${e.message}');
    }
  }
}
