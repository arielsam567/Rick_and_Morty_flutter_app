class HttpResponse {
  final dynamic data;
  final int statusCode;

  HttpResponse({
    required this.data,
    required this.statusCode,
  });
}

class HttpException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  HttpException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() {
    return 'HttpException: $message (status: $statusCode)';
  }
}

abstract class HttpClientBase {
  Future<HttpResponse> get(String path,
      {Map<String, dynamic>? queryParameters});

  Future<HttpResponse> post(String path,
      {data, Map<String, dynamic>? queryParameters});
}
