import 'package:dio/dio.dart';

/// Resposta HTTP padronizada
class HttpResponse {
  final dynamic data;
  final int statusCode;

  HttpResponse({
    required this.data,
    required this.statusCode,
  });
}

/// Cliente HTTP usando Dio
class HttpClient {
  final Dio _dio;

  HttpClient(this._dio);

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
