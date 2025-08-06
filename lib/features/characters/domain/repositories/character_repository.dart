import 'package:dartz/dartz.dart';
import 'package:ricky_and_martie_app/core/error/failures.dart';
import 'package:ricky_and_martie_app/features/characters/domain/entities/character.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<Character>>> getCharacters({int page = 1});
  Future<Either<Failure, Character>> getCharacterById(int id);
  Future<Either<Failure, List<Character>>> searchCharactersByName(String name);
  Future<Either<Failure, List<Character>>> getCharactersByIds(List<int> ids);
}
