class HttpResponse {
  final dynamic data;
  final int statusCode;

  HttpResponse({
    required this.data,
    required this.statusCode,
  });
}

/// Classe abstrata para cliente HTTP
abstract class HttpClientBase {
  /// Realiza uma requisição GET
  Future<HttpResponse> get(String path,
      {Map<String, dynamic>? queryParameters});

  /// Realiza uma requisição POST
  Future<HttpResponse> post(String path,
      {data, Map<String, dynamic>? queryParameters});
}
