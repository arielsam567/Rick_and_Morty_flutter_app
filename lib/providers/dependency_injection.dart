import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:ricky_and_martie_app/core/http/dio_config.dart';
import 'package:ricky_and_martie_app/core/http/http_client_abstract.dart';
import 'package:ricky_and_martie_app/core/http/http_client_impl.dart';
import 'package:ricky_and_martie_app/repositories/rickandmorty_repository.dart';
import 'package:ricky_and_martie_app/pages/details/details_controller.dart';
import 'package:ricky_and_martie_app/pages/home/home_controller.dart';

class DependencyInjection {
  static List<dynamic> get providers => [
        Provider<Dio>(
          create: (_) => DioConfig.createDio(),
        ),
        Provider<HttpClientBase>(
          create: (context) => HttpClient(context.read<Dio>()),
        ),
        Provider<RickAndMortyRepository>(
          create: (context) =>
              RickAndMortyRepository(context.read<HttpClientBase>()),
        ),
        ChangeNotifierProvider<HomeController>(
          create: (context) =>
              HomeController(context.read<RickAndMortyRepository>()),
        ),
        ChangeNotifierProvider<DetailsController>(
          create: (context) =>
              DetailsController(context.read<RickAndMortyRepository>()),
        ),
      ];
}
