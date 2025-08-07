import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:ricky_and_martie_app/config/dio_config.dart';
import 'package:ricky_and_martie_app/core/http_client_abstract.dart';
import 'package:ricky_and_martie_app/core/http_client_impl.dart';
import 'package:ricky_and_martie_app/repositories/rickandmorty_repository.dart';

class DependencyInjection {
  static List<Provider> providers = [
    // Provider para o Dio
    Provider<Dio>(
      create: (_) => DioConfig.createDio(),
    ),

    // Provider para o HttpClientBase (classe abstrata)
    Provider<HttpClientBase>(
      create: (context) => HttpClient(context.read<Dio>()),
    ),

    // Provider para o RickAndMortyRepository
    Provider<RickAndMortyRepository>(
      create: (context) =>
          RickAndMortyRepository(context.read<HttpClientBase>()),
    ),
  ];
}
