import 'package:dartz/dartz.dart';
import 'package:ricky_and_martie_app/core/http_client_abstract.dart';
import 'package:ricky_and_martie_app/models/character.dart';
import 'package:ricky_and_martie_app/models/paginated_response.dart';

class RickAndMortyRepository {
  final HttpClientBase _httpClient;

  RickAndMortyRepository(this._httpClient);

  Future<Either<String, PaginatedResponse<Character>>> getCharacters(
      {int page = 1}) async {
    try {
      final response =
          await _httpClient.get('character', queryParameters: {'page': page});
      return Right(PaginatedResponse<Character>.fromJson(
        response.data,
        (json) => Character.fromJson(json),
      ));
    } catch (e) {
      return Left('Erro ao buscar personagens: $e');
    }
  }

  Future<Either<String, Character>> getCharacterById(int id) async {
    try {
      final response = await _httpClient.get('character/$id');
      return Right(Character.fromJson(response.data));
    } catch (e) {
      return Left('Erro ao buscar personagem: $e');
    }
  }

  Future<Either<String, PaginatedResponse<Character>>> searchCharactersByName(
      String name,
      {int page = 1}) async {
    try {
      final response = await _httpClient
          .get('character', queryParameters: {'name': name, 'page': page});

      return Right(PaginatedResponse<Character>.fromJson(
        response.data,
        (json) => Character.fromJson(json),
      ));
    } catch (e) {
      return Left('Erro ao buscar personagens por nome: $e');
    }
  }

  Future<Either<String, List<Character>>> getCharactersByIds(
      List<int> ids) async {
    try {
      final idsString = ids.join(',');
      final response = await _httpClient.get('character/$idsString');

      if (ids.length == 1) {
        return Right([Character.fromJson(response.data)]);
      } else {
        return Right((response.data as List)
            .map((json) => Character.fromJson(json))
            .toList());
      }
    } catch (e) {
      return Left('Erro ao buscar personagens por IDs: $e');
    }
  }
}
