class HttpResponse {
  final dynamic data;
  final int statusCode;

  HttpResponse({
    required this.data,
    required this.statusCode,
  });
}

abstract class HttpClientBase {
  Future<HttpResponse> get(String path,
      {Map<String, dynamic>? queryParameters});

  Future<HttpResponse> post(String path,
      {data, Map<String, dynamic>? queryParameters});
}
