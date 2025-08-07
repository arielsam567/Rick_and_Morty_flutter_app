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
       if (_isNotFoundError(e)) {
        return Right(PaginatedResponse<Character>(
          info: Info(
            count: 0,
            pages: 0,
          ),
          results: [],
        ));
      }
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

   bool _isNotFoundError(error) {
    if (error is Exception) {
      final errorString = error.toString().toLowerCase();
      return errorString.contains('404') ||
          errorString.contains('not found') ||
          errorString.contains('não encontrado');
    }
    return false;
  }

   String _getUserFriendlyErrorMessage(error, String action) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('404') || errorString.contains('not found')) {
      return 'Nenhum resultado encontrado';
    }

    if (errorString.contains('timeout') || errorString.contains('timed out')) {
      return 'Tempo limite excedido. Verifique sua conexão com a internet.';
    }

    if (errorString.contains('network') || errorString.contains('connection')) {
      return 'Erro de conexão. Verifique sua internet e tente novamente.';
    }

    if (errorString.contains('500') || errorString.contains('server')) {
      return 'Erro no servidor. Tente novamente em alguns instantes.';
    }

    // Para outros erros, retorna uma mensagem genérica
    return 'Erro ao $action. Tente novamente.';
  }
}
