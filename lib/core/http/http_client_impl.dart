import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ricky_and_martie_app/core/http/http_client_abstract.dart';
import 'package:ricky_and_martie_app/core/storage/storage_impl.dart';
import 'dart:convert';

class HttpClient implements HttpClientBase {
  final Dio _dio;

  HttpClient(this._dio);

  @override
  Future<HttpResponse> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final cacheKey = _generateCacheKey(path, queryParameters);

      final cachedData = await _getFromCache(cacheKey);
      if (cachedData != null) {
        debugPrint('🔍 Dados encontrados no cache: $cacheKey');
        return cachedData;
      }
      debugPrint('🔍 Não há dados no cache para: $cacheKey');
      final response = await _dio.get(path, queryParameters: queryParameters);
      final httpResponse = HttpResponse(
        data: response.data,
        statusCode: response.statusCode ?? 200,
      );

      await _saveToCache(cacheKey, httpResponse);

      return httpResponse;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final message = e.message ?? 'Erro desconhecido';
      throw HttpException(
        message: message,
        statusCode: statusCode,
        data: e.response?.data,
      );
    }
  }

  String _generateCacheKey(String path, Map<String, dynamic>? queryParameters) {
    final queryString = queryParameters != null
        ? queryParameters.entries.map((e) => '${e.key}=${e.value}').join('&')
        : '';
    return '$path?$queryString';
  }

  Future<HttpResponse?> _getFromCache(String cacheKey) async {
    try {
      final storage = await LocalStorageService.getInstance();
      final cachedData = await storage.getString('cache_$cacheKey');

      if (cachedData != null) {
        final decodedData = json.decode(cachedData);
        return HttpResponse(
          data: decodedData['data'],
          statusCode: decodedData['statusCode'],
        );
      }
      return null;
    } catch (e) {
      debugPrint('Erro ao buscar cache: $e');
      return null;
    }
  }

  Future<void> _saveToCache(String cacheKey, HttpResponse response) async {
    try {
      final storage = await LocalStorageService.getInstance();
      final cacheData = {
        'data': response.data,
        'statusCode': response.statusCode,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };

      await storage.setString('cache_$cacheKey', json.encode(cacheData));
    } catch (e) {
      debugPrint('Erro ao salvar cache: $e');
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
      final statusCode = e.response?.statusCode;
      final message = e.message ?? 'Erro desconhecido';
      throw HttpException(
        message: message,
        statusCode: statusCode,
        data: e.response?.data,
      );
    }
  }
}
