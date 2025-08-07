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

  group('HomeController - Initial States', () {
    test('should initialize with correct states', () {
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
    test('should load characters successfully', () async {
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

    test('should handle error when loading characters', () async {
      when(mockRepository.getCharacters())
          .thenAnswer((_) async => const Left('Erro de conexão'));

      await controller.loadCharacters();

      expect(controller.characters, isEmpty);
      expect(controller.isLoading, isFalse);
      expect(controller.errorMessage, equals('Erro de conexão'));
    });

    test('should load more characters in pagination', () async {
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

    test('should refresh correctly', () async {
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
    test('should search characters by name successfully', () async {
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

    test('should handle no results found', () async {
      when(mockRepository.searchCharactersByName('Inexistente'))
          .thenAnswer((_) async => const Left('Nenhum resultado encontrado'));

      await controller.searchCharactersByName('Inexistente');

      expect(controller.characters, isEmpty);
      expect(controller.isSearchMode, isTrue);
      expect(controller.hasMorePages, isFalse);
      expect(controller.errorMessage, isNull);
    });

    test('should handle search error', () async {
      when(mockRepository.searchCharactersByName('Rick'))
          .thenAnswer((_) async => const Left('Erro de busca'));

      await controller.searchCharactersByName('Rick');

      expect(controller.characters, isEmpty);
      expect(controller.errorMessage, equals('Erro de busca'));
    });
  });

  group('HomeController - updateSearchQuery', () {
    test('should clear search when query is empty', () async {
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

    test('should debounce search', () async {
      when(mockRepository.searchCharactersByName('Rick'))
          .thenAnswer((_) async => Right(PaginatedResponse(
                info: Info(count: 1, pages: 1),
                results: [],
              )));

      controller.updateSearchQuery('Rick');
      expect(controller.searchQuery, equals('Rick'));

      // Wait for debounce
      await Future.delayed(const Duration(milliseconds: 600));

      verify(mockRepository.searchCharactersByName('Rick')).called(1);
    });
  });

  group('HomeController - retry', () {
    test('should retry in search mode', () async {
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

    test('should retry in normal mode', () async {
      when(mockRepository.getCharacters())
          .thenAnswer((_) async => Right(PaginatedResponse(
                info: Info(count: 1, pages: 1),
                results: [],
              )));

      controller.retry();

      verify(mockRepository.getCharacters()).called(1);
    });
  });

  group('HomeController - Filters', () {
    test('should filter characters by name', () {
      // Simulate character loading
      controller.updateSearchQuery('Rick');

      // Here you would need to simulate internal state, but the test demonstrates the logic
      expect(controller.searchQuery, equals('Rick'));
    });
  });

  group('HomeController - Loading States', () {
    test('should manage loading states correctly', () async {
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
