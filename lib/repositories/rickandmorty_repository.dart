import 'package:ricky_and_martie_app/core/network/http_client_abst.dart';
import 'package:ricky_and_martie_app/models/character.dart';
import 'package:ricky_and_martie_app/models/paginated_response.dart';

class RickAndMortyRepository {
  final HttpClient _httpClient;

  RickAndMortyRepository(this._httpClient);

  Future<PaginatedResponse<Character>> getCharacters({int page = 1}) async {
    try {
      final response =
          await _httpClient.get('character', queryParameters: {'page': page});

      return PaginatedResponse<Character>.fromJson(
        response.data,
        (json) => Character.fromJson(json),
      );
    } catch (e) {
      throw Exception('Erro ao buscar personagens: $e');
    }
  }

  Future<Character> getCharacterById(int id) async {
    try {
      final response = await _httpClient.get('character/$id');
      return Character.fromJson(response.data);
    } catch (e) {
      throw Exception('Erro ao buscar personagem: $e');
    }
  }

  /// Busca personagens por nome
  Future<PaginatedResponse<Character>> searchCharactersByName(
      String name) async {
    try {
      final response =
          await _httpClient.get('character', queryParameters: {'name': name});

      return PaginatedResponse<Character>.fromJson(
        response.data,
        (json) => Character.fromJson(json),
      );
    } catch (e) {
      throw Exception('Erro ao buscar personagens por nome: $e');
    }
  }

  /// Busca múltiplos personagens por IDs
  Future<List<Character>> getCharactersByIds(List<int> ids) async {
    try {
      final idsString = ids.join(',');
      final response = await _httpClient.get('character/$idsString');

      if (ids.length == 1) {
        return [Character.fromJson(response.data)];
      } else {
        return (response.data as List)
            .map((json) => Character.fromJson(json))
            .toList();
      }
    } catch (e) {
      throw Exception('Erro ao buscar personagens por IDs: $e');
    }
  }
}
