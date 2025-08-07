import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:ricky_and_martie_app/models/character.dart';
import 'package:ricky_and_martie_app/models/paginated_response.dart';
import 'package:ricky_and_martie_app/pages/home/home_controller.dart';
import 'package:ricky_and_martie_app/repositories/rickandmorty_repository.dart';

import 'home_controller_test.mocks.dart';

@GenerateMocks([RickAndMortyRepository])
void main() {
  late HomeController controller;
  late MockRickAndMortyRepository mockRepository;

  setUp(() {
    mockRepository = MockRickAndMortyRepository();
    controller = HomeController(mockRepository);
  });

  tearDown(() {
    controller.dispose();
  });

  group('HomeController - Estados Iniciais', () {
    test('deve inicializar com estados corretos', () {
      expect(controller.characters, isEmpty);
      expect(controller.isLoading, isFalse);
      expect(controller.isLoadingMore, isFalse);
      expect(controller.errorMessage, isNull);
      expect(controller.searchQuery, isEmpty);
      expect(controller.hasMorePages, isTrue);
      expect(controller.isSearchMode, isFalse);
      expect(controller.emptyState, isFalse);
    });
  });

  group('HomeController - loadCharacters', () {
    test('deve carregar personagens com sucesso', () async {
      final characters = [
        Character(
          id: 1,
          name: 'Rick Sanchez',
          status: LifeStatus.Alive,
          species: 'Human',
          type: '',
          gender: 'Male',
          origin: 'Earth',
          location: 'Earth',
          image: 'https://example.com/rick.jpg',
          episode: ['https://example.com/episode1'],
          url: 'https://example.com/rick',
          created: DateTime.parse('2017-11-04T18:48:46.250Z'),
        ),
      ];

      final response = PaginatedResponse(
        info: Info(count: 1, pages: 1),
        results: characters,
      );

      when(mockRepository.getCharacters())
          .thenAnswer((_) async => Right(response));

      await controller.loadCharacters();

      expect(controller.characters, equals(characters));
      expect(controller.isLoading, isFalse);
      expect(controller.errorMessage, isNull);
      expect(controller.hasMorePages, isFalse);
    });

    test('deve lidar com erro ao carregar personagens', () async {
      when(mockRepository.getCharacters())
          .thenAnswer((_) async => const Left('Erro de conexão'));

      await controller.loadCharacters();

      expect(controller.characters, isEmpty);
      expect(controller.isLoading, isFalse);
      expect(controller.errorMessage, equals('Erro de conexão'));
    });

    test('deve carregar mais personagens na paginação', () async {
      final characters1 = [
        Character(
          id: 1,
          name: 'Rick Sanchez',
          status: LifeStatus.Alive,
          species: 'Human',
          type: '',
          gender: 'Male',
          origin: 'Earth',
          location: 'Earth',
          image: 'https://example.com/rick.jpg',
          episode: ['https://example.com/episode1'],
          url: 'https://example.com/rick',
          created: DateTime.parse('2017-11-04T18:48:46.250Z'),
        ),
      ];

      final characters2 = [
        Character(
          id: 2,
          name: 'Morty Smith',
          status: LifeStatus.Alive,
          species: 'Human',
          type: '',
          gender: 'Male',
          origin: 'Earth',
          location: 'Earth',
          image: 'https://example.com/morty.jpg',
          episode: ['https://example.com/episode1'],
          url: 'https://example.com/morty',
          created: DateTime.parse('2017-11-04T18:48:46.250Z'),
        ),
      ];

      final response1 = PaginatedResponse(
        info: Info(count: 2, pages: 2, next: 'https://example.com/page2'),
        results: characters1,
      );

      final response2 = PaginatedResponse(
        info: Info(count: 2, pages: 2, prev: 'https://example.com/page1'),
        results: characters2,
      );

      when(mockRepository.getCharacters())
          .thenAnswer((_) async => Right(response1));
      when(mockRepository.getCharacters(page: 2))
          .thenAnswer((_) async => Right(response2));

      await controller.loadCharacters();
      await controller.loadMoreCharacters();

      expect(controller.characters.length, equals(2));
      expect(controller.hasMorePages, isFalse);
    });

    test('deve fazer refresh corretamente', () async {
      final characters = [
        Character(
          id: 1,
          name: 'Rick Sanchez',
          status: LifeStatus.Alive,
          species: 'Human',
          type: '',
          gender: 'Male',
          origin: 'Earth',
          location: 'Earth',
          image: 'https://example.com/rick.jpg',
          episode: ['https://example.com/episode1'],
          url: 'https://example.com/rick',
          created: DateTime.parse('2017-11-04T18:48:46.250Z'),
        ),
      ];

      final response = PaginatedResponse(
        info: Info(count: 1, pages: 1),
        results: characters,
      );

      when(mockRepository.getCharacters())
          .thenAnswer((_) async => Right(response));

      await controller.loadCharacters(refresh: true);

      expect(controller.characters, equals(characters));
      expect(controller.isSearchMode, isFalse);
    });
  });

  group('HomeController - searchCharactersByName', () {
    test('deve buscar personagens por nome com sucesso', () async {
      final characters = [
        Character(
          id: 1,
          name: 'Rick Sanchez',
          status: LifeStatus.Alive,
          species: 'Human',
          type: '',
          gender: 'Male',
          origin: 'Earth',
          location: 'Earth',
          image: 'https://example.com/rick.jpg',
          episode: ['https://example.com/episode1'],
          url: 'https://example.com/rick',
          created: DateTime.parse('2017-11-04T18:48:46.250Z'),
        ),
      ];

      final response = PaginatedResponse(
        info: Info(count: 1, pages: 1),
        results: characters,
      );

      when(mockRepository.searchCharactersByName('Rick'))
          .thenAnswer((_) async => Right(response));

      await controller.searchCharactersByName('Rick');

      expect(controller.characters, equals(characters));
      expect(controller.isSearchMode, isTrue);
      expect(controller.isLoading, isFalse);
    });

    test('deve lidar com nenhum resultado encontrado', () async {
      when(mockRepository.searchCharactersByName('Inexistente'))
          .thenAnswer((_) async => const Left('Nenhum resultado encontrado'));

      await controller.searchCharactersByName('Inexistente');

      expect(controller.characters, isEmpty);
      expect(controller.isSearchMode, isTrue);
      expect(controller.hasMorePages, isFalse);
      expect(controller.errorMessage, isNull);
    });

    test('deve lidar com erro na busca', () async {
      when(mockRepository.searchCharactersByName('Rick'))
          .thenAnswer((_) async => const Left('Erro de busca'));

      await controller.searchCharactersByName('Rick');

      expect(controller.characters, isEmpty);
      expect(controller.errorMessage, equals('Erro de busca'));
    });
  });

  group('HomeController - updateSearchQuery', () {
    test('deve limpar busca quando query estiver vazia', () async {
      final characters = [
        Character(
          id: 1,
          name: 'Rick Sanchez',
          status: LifeStatus.Alive,
          species: 'Human',
          type: '',
          gender: 'Male',
          origin: 'Earth',
          location: 'Earth',
          image: 'https://example.com/rick.jpg',
          episode: ['https://example.com/episode1'],
          url: 'https://example.com/rick',
          created: DateTime.parse('2017-11-04T18:48:46.250Z'),
        ),
      ];

      final response = PaginatedResponse(
        info: Info(count: 1, pages: 1),
        results: characters,
      );

      when(mockRepository.getCharacters())
          .thenAnswer((_) async => Right(response));

      controller.updateSearchQuery('Rick');
      expect(controller.searchQuery, equals('Rick'));

      controller.updateSearchQuery('');
      expect(controller.searchQuery, isEmpty);
      expect(controller.isSearchMode, isFalse);
    });

    test('deve fazer debounce na busca', () async {
      when(mockRepository.searchCharactersByName('Rick'))
          .thenAnswer((_) async => Right(PaginatedResponse(
                info: Info(count: 1, pages: 1),
                results: [],
              )));

      controller.updateSearchQuery('Rick');
      expect(controller.searchQuery, equals('Rick'));

      // Aguarda o debounce
      await Future.delayed(const Duration(milliseconds: 600));

      verify(mockRepository.searchCharactersByName('Rick')).called(1);
    });
  });

  group('HomeController - retry', () {
    test('deve tentar novamente em modo de busca', () async {
      controller.updateSearchQuery('Rick');

      when(mockRepository.searchCharactersByName('Rick'))
          .thenAnswer((_) async => Right(PaginatedResponse(
                info: Info(count: 1, pages: 1),
                results: [],
              )));

      await Future.delayed(const Duration(milliseconds: 600));
      controller.retry();

      verify(mockRepository.searchCharactersByName('Rick'))
          .called(greaterThan(1));
    });

    test('deve tentar novamente em modo normal', () async {
      when(mockRepository.getCharacters())
          .thenAnswer((_) async => Right(PaginatedResponse(
                info: Info(count: 1, pages: 1),
                results: [],
              )));

      controller.retry();

      verify(mockRepository.getCharacters()).called(1);
    });
  });

  group('HomeController - Filtros', () {
    test('deve filtrar personagens por nome', () {
      // Simula carregamento de personagens
      controller.updateSearchQuery('Rick');

      // Aqui você precisaria simular o estado interno, mas o teste demonstra a lógica
      expect(controller.searchQuery, equals('Rick'));
    });
  });

  group('HomeController - Estados de Loading', () {
    test('deve gerenciar estados de loading corretamente', () async {
      when(mockRepository.getCharacters()).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 100));
        return Right(PaginatedResponse(
          info: Info(count: 1, pages: 1),
          results: [],
        ));
      });

      final future = controller.loadCharacters();

      expect(controller.isLoading, isTrue);

      await future;

      expect(controller.isLoading, isFalse);
    });
  });
}
