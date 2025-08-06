import 'package:dio/dio.dart';
import 'package:ricky_and_martie_app/models/character.dart';
import 'package:ricky_and_martie_app/models/paginated_response.dart';

class RickAndMortyRepository {
  final Dio _dio;

  RickAndMortyRepository(this._dio);

  /// Busca todos os personagens com paginação
  Future<PaginatedResponse<Character>> getCharacters({int page = 1}) async {
    try {
      final response =
          await _dio.get('character', queryParameters: {'page': page});

      return PaginatedResponse<Character>.fromJson(
        response.data,
        (json) => Character.fromJson(json),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Busca um personagem específico por ID
  Future<Character> getCharacterById(int id) async {
    try {
      final response = await _dio.get('character/$id');
      return Character.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Busca personagens por nome
  Future<PaginatedResponse<Character>> searchCharactersByName(
      String name) async {
    try {
      final response =
          await _dio.get('character', queryParameters: {'name': name});

      return PaginatedResponse<Character>.fromJson(
        response.data,
        (json) => Character.fromJson(json),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Busca múltiplos personagens por IDs
  Future<List<Character>> getCharactersByIds(List<int> ids) async {
    try {
      final idsString = ids.join(',');
      final response = await _dio.get('character/$idsString');

      if (ids.length == 1) {
        return [Character.fromJson(response.data)];
      } else {
        return (response.data as List)
            .map((json) => Character.fromJson(json))
            .toList();
      }
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
