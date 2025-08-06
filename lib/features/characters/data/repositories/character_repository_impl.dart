import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ricky_and_martie_app/core/error/failures.dart';
import 'package:ricky_and_martie_app/features/characters/data/datasources/character_remote_data_source.dart';
import 'package:ricky_and_martie_app/features/characters/domain/entities/character.dart';
import 'package:ricky_and_martie_app/features/characters/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Character>>> getCharacters({int page = 1}) async {
    try {
      final response = await remoteDataSource.getCharacters(page: page);
      return Right(response.results);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(const ServerFailure('Erro inesperado'));
    }
  }

  @override
  Future<Either<Failure, Character>> getCharacterById(int id) async {
    try {
      final character = await remoteDataSource.getCharacterById(id);
      return Right(character);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(const ServerFailure('Erro inesperado'));
    }
  }

  @override
  Future<Either<Failure, List<Character>>> searchCharactersByName(
      String name) async {
    try {
      final response = await remoteDataSource.searchCharactersByName(name);
      return Right(response.results);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(const ServerFailure('Erro inesperado'));
    }
  }

  @override
  Future<Either<Failure, List<Character>>> getCharactersByIds(
      List<int> ids) async {
    try {
      final characters = await remoteDataSource.getCharactersByIds(ids);
      return Right(characters);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(const ServerFailure('Erro inesperado'));
    }
  }

  Failure _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(
            'Timeout na conexão. Verifique sua internet.');

      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 404:
            return const ServerFailure('Recurso não encontrado.');
          case 500:
            return const ServerFailure('Erro interno do servidor.');
          default:
            return ServerFailure(
                'Erro na requisição: ${e.response?.statusCode}');
        }

      case DioExceptionType.cancel:
        return const NetworkFailure('Requisição cancelada.');

      case DioExceptionType.connectionError:
        return const NetworkFailure('Erro de conexão. Verifique sua internet.');

      case DioExceptionType.badCertificate:
        return const NetworkFailure('Certificado SSL inválido.');

      case DioExceptionType.unknown:
        return NetworkFailure('Erro desconhecido: ${e.message}');
    }
  }
}
