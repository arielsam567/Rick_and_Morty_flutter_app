import 'package:dio/dio.dart';
import 'package:ricky_and_martie_app/core/http_client_abstract.dart';

/// Cliente HTTP usando Dio
class HttpClient implements HttpClientBase {
  final Dio _dio;

  HttpClient(this._dio);

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

  @override
  Future<HttpResponse> post(String path,
      {data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.post(path, data: data, queryParameters: queryParameters);
      return HttpResponse(
        data: response.data,
        statusCode: response.statusCode ?? 201,
      );
    } on DioException catch (e) {
      throw Exception('Erro na requisição: ${e.message}');
    }
  }
}
