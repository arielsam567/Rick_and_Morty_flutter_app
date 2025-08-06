import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:ricky_and_martie_app/config/dio_config.dart';
import 'package:ricky_and_martie_app/core/network/http_client.dart';
import 'package:ricky_and_martie_app/core/network/http_client_abst.dart';
import 'package:ricky_and_martie_app/features/characters/data/datasources/character_remote_data_source.dart';
import 'package:ricky_and_martie_app/features/characters/data/repositories/character_repository_impl.dart';
import 'package:ricky_and_martie_app/features/characters/domain/repositories/character_repository.dart';
import 'package:ricky_and_martie_app/features/characters/domain/usecases/get_characters.dart';
import 'package:ricky_and_martie_app/features/characters/domain/usecases/get_character_by_id.dart';
import 'package:ricky_and_martie_app/repositories/rickandmorty_repository.dart';

class DependencyInjection {
  static List<Provider> providers = [
    // Provider para o Dio
    Provider<Dio>(
      create: (_) => DioConfig.createDio(),
    ),

    // Provider para o HttpClient (abstração)
    Provider<HttpClient>(
      create: (context) => DioHttpClient(context.read<Dio>()),
    ),

    // Provider para o RickAndMortyRepository (usando abstração)
    Provider<RickAndMortyRepository>(
      create: (context) => RickAndMortyRepository(context.read<HttpClient>()),
    ),

    // Provider para o DataSource
    Provider<CharacterRemoteDataSource>(
      create: (context) => CharacterRemoteDataSourceImpl(
        context.read<Dio>(),
      ),
    ),

    // Provider para o Repository
    Provider<CharacterRepository>(
      create: (context) => CharacterRepositoryImpl(
        context.read<CharacterRemoteDataSource>(),
      ),
    ),

    // Providers para os UseCases
    Provider<GetCharacters>(
      create: (context) => GetCharacters(
        context.read<CharacterRepository>(),
      ),
    ),

    Provider<GetCharacterById>(
      create: (context) => GetCharacterById(
        context.read<CharacterRepository>(),
      ),
    ),
  ];
}
