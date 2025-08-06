/// Abstração para cliente HTTP
abstract class HttpClient {
  Future<HttpResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  });
  Future<HttpResponse> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  });
  Future<HttpResponse> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  });
  Future<HttpResponse> delete(String path,
      {Map<String, dynamic>? queryParameters});
}

/// Resposta HTTP padronizada
class HttpResponse {
  final dynamic data;
  final int statusCode;
  final Map<String, dynamic>? headers;

  HttpResponse({
    required this.data,
    required this.statusCode,
    this.headers,
  });
}
