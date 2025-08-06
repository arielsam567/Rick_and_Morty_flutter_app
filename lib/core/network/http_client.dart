import 'package:dio/dio.dart';
import 'package:ricky_and_martie_app/core/network/http_client_abst.dart';

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
        headers: response.headers.map,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<HttpResponse> post(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.post(path, data: data, queryParameters: queryParameters);
      return HttpResponse(
        data: response.data,
        statusCode: response.statusCode ?? 200,
        headers: response.headers.map,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<HttpResponse> put(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.put(path, data: data, queryParameters: queryParameters);
      return HttpResponse(
        data: response.data,
        statusCode: response.statusCode ?? 200,
        headers: response.headers.map,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<HttpResponse> delete(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.delete(path, queryParameters: queryParameters);
      return HttpResponse(
        data: response.data,
        statusCode: response.statusCode ?? 200,
        headers: response.headers.map,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Tratamento de erros do Dio
  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Timeout na conexão. Verifique sua internet.');

      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 404:
            return Exception('Recurso não encontrado.');
          case 500:
            return Exception('Erro interno do servidor.');
          default:
            return Exception('Erro na requisição: ${e.response?.statusCode}');
        }

      case DioExceptionType.cancel:
        return Exception('Requisição cancelada.');

      case DioExceptionType.connectionError:
        return Exception('Erro de conexão. Verifique sua internet.');

      case DioExceptionType.badCertificate:
        return Exception('Certificado SSL inválido.');

      case DioExceptionType.unknown:
        return Exception('Erro desconhecido: ${e.message}');
    }
  }
}
