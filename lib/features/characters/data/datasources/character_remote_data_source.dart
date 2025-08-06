import 'package:dio/dio.dart';
import 'package:ricky_and_martie_app/features/characters/data/models/character_model.dart';
import 'package:ricky_and_martie_app/features/characters/data/models/paginated_response_model.dart';

abstract class CharacterRemoteDataSource {
  Future<PaginatedResponseModel<CharacterModel>> getCharacters({int page = 1});
  Future<CharacterModel> getCharacterById(int id);
  Future<PaginatedResponseModel<CharacterModel>> searchCharactersByName(
      String name);
  Future<List<CharacterModel>> getCharactersByIds(List<int> ids);
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final Dio dio;

  CharacterRemoteDataSourceImpl(this.dio);

  @override
  Future<PaginatedResponseModel<CharacterModel>> getCharacters(
      {int page = 1}) async {
    final response =
        await dio.get('character', queryParameters: {'page': page});

    return PaginatedResponseModel<CharacterModel>.fromJson(
      response.data,
      (json) => CharacterModel.fromJson(json),
    );
  }

  @override
  Future<CharacterModel> getCharacterById(int id) async {
    final response = await dio.get('character/$id');
    return CharacterModel.fromJson(response.data);
  }

  @override
  Future<PaginatedResponseModel<CharacterModel>> searchCharactersByName(
      String name) async {
    final response =
        await dio.get('character', queryParameters: {'name': name});

    return PaginatedResponseModel<CharacterModel>.fromJson(
      response.data,
      (json) => CharacterModel.fromJson(json),
    );
  }

  @override
  Future<List<CharacterModel>> getCharactersByIds(List<int> ids) async {
    final idsString = ids.join(',');
    final response = await dio.get('character/$idsString');

    if (ids.length == 1) {
      return [CharacterModel.fromJson(response.data)];
    } else {
      return (response.data as List)
          .map((json) => CharacterModel.fromJson(json))
          .toList();
    }
  }
}
