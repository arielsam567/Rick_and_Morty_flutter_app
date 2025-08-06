import 'package:dartz/dartz.dart';
import 'package:ricky_and_martie_app/core/error/failures.dart';
import 'package:ricky_and_martie_app/core/usecases/usecase.dart';
import 'package:ricky_and_martie_app/features/characters/domain/entities/character.dart';
import 'package:ricky_and_martie_app/features/characters/domain/repositories/character_repository.dart';

class GetCharacters implements UseCase<List<Character>, GetCharactersParams> {
  final CharacterRepository repository;

  GetCharacters(this.repository);

  @override
  Future<Either<Failure, List<Character>>> call(
      GetCharactersParams params) async {
    return await repository.getCharacters(page: params.page);
  }
}

class GetCharactersParams {
  final int page;

  const GetCharactersParams({this.page = 1});
}
