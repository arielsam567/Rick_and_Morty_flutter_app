import 'package:dartz/dartz.dart';
import 'package:ricky_and_martie_app/core/error/failures.dart';
import 'package:ricky_and_martie_app/core/usecases/usecase.dart';
import 'package:ricky_and_martie_app/features/characters/domain/entities/character.dart';
import 'package:ricky_and_martie_app/features/characters/domain/repositories/character_repository.dart';

class GetCharacterById implements UseCase<Character, GetCharacterByIdParams> {
  final CharacterRepository repository;

  GetCharacterById(this.repository);

  @override
  Future<Either<Failure, Character>> call(GetCharacterByIdParams params) async {
    return await repository.getCharacterById(params.id);
  }
}

class GetCharacterByIdParams {
  final int id;

  const GetCharacterByIdParams(this.id);
}
