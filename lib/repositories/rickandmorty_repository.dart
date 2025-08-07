import 'package:dartz/dartz.dart';
import 'package:ricky_and_martie_app/infrastructure/http/http_client_abstract.dart';
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
      return Left(_getUserFriendlyErrorMessage(e, 'carregar personagens'));
    }
  }

  Future<Either<String, Character>> getCharacterById(int id) async {
    try {
      final response = await _httpClient.get('character/$id');
      return Right(Character.fromJson(response.data));
    } catch (e) {
      return Left(_getUserFriendlyErrorMessage(e, 'carregar personagem'));
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
      return Left(_getUserFriendlyErrorMessage(e, 'buscar personagens'));
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
      return Left(_getUserFriendlyErrorMessage(e, 'carregar personagens'));
    }
  }

  String _getUserFriendlyErrorMessage(error, String action) {
    if (error is HttpException) {
      switch (error.statusCode) {
        case 404:
          return 'Nenhum resultado encontrado';
        case 500:
          return 'Erro no servidor. Tente novamente em alguns instantes.';
        case 408:
        case 504:
          return 'Tempo limite excedido. Verifique sua conexão com a internet.';
        default:
          break;
      }
    }

    return 'Erro ao $action. Tente novamente.';
  }
}
