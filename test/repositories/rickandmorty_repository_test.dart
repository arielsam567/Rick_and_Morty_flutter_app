import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:ricky_and_martie_app/infrastructure/http/http_client_abstract.dart';
import 'package:ricky_and_martie_app/models/character.dart';
import 'package:ricky_and_martie_app/models/paginated_response.dart';
import 'package:ricky_and_martie_app/repositories/rickandmorty_repository.dart';

@GenerateMocks([HttpClientBase])
import 'rickandmorty_repository_test.mocks.dart';

void main() {
  group('RickAndMortyRepository Tests', () {
    late MockHttpClientBase mockHttpClient;
    late RickAndMortyRepository repository;

    setUp(() {
      mockHttpClient = MockHttpClientBase();
      repository = RickAndMortyRepository(mockHttpClient);
    });

    group('getCharacters', () {
      test('should return PaginatedResponse when API call is successful',
          () async {
        final mockResponse = {
          'info': {
            'count': 826,
            'pages': 42,
            'next': 'https://rickandmortyapi.com/api/character/?page=2',
            'prev': null
          },
          'results': [
            {
              'id': 1,
              'name': 'Rick Sanchez',
              'status': 'Alive',
              'species': 'Human',
              'type': '',
              'gender': 'Male',
              'image':
                  'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
              'episode': [
                'https://rickandmortyapi.com/api/episode/1',
                'https://rickandmortyapi.com/api/episode/2'
              ],
              'url': 'https://rickandmortyapi.com/api/character/1',
              'created': '2017-11-04T18:48:46.250Z',
              'origin': {'name': 'Earth (C-137)'},
              'location': {'name': 'Earth (Replacement Dimension)'}
            }
          ]
        };

        when(mockHttpClient.get('character', queryParameters: {'page': 1}))
            .thenAnswer(
                (_) async => HttpResponse(data: mockResponse, statusCode: 200));

        final result = await repository.getCharacters();

        expect(result.isRight(), isTrue);
        result.fold(
          (error) => fail('Should not return error'),
          (paginatedResponse) {
            expect(paginatedResponse, isA<PaginatedResponse<Character>>());
            expect(paginatedResponse.results.length, equals(1));
            expect(
                paginatedResponse.results.first.name, equals('Rick Sanchez'));
            expect(paginatedResponse.info.count, equals(826));
            expect(paginatedResponse.info.pages, equals(42));
          },
        );
      });

      test('should return error message when API call fails', () async {
        when(mockHttpClient.get('character', queryParameters: {'page': 1}))
            .thenThrow(
                HttpException(message: 'Network error', statusCode: 500));

        final result = await repository.getCharacters();

        expect(result.isLeft(), isTrue);
        result.fold(
          (error) {
            expect(error, contains('Erro no servidor'));
          },
          (response) => fail('Should not return success'),
        );
      });

      test('should return 404 error message when no results found', () async {
        when(mockHttpClient.get('character', queryParameters: {'page': 999}))
            .thenThrow(HttpException(message: 'Not found', statusCode: 404));

        final result = await repository.getCharacters(page: 999);

        expect(result.isLeft(), isTrue);
        result.fold(
          (error) {
            expect(error, equals('Nenhum resultado encontrado'));
          },
          (response) => fail('Should not return success'),
        );
      });
    });

    group('getCharacterById', () {
      test('should return Character when API call is successful', () async {
        final mockResponse = {
          'id': 1,
          'name': 'Rick Sanchez',
          'status': 'Alive',
          'species': 'Human',
          'type': '',
          'gender': 'Male',
          'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
          'episode': [
            'https://rickandmortyapi.com/api/episode/1',
            'https://rickandmortyapi.com/api/episode/2'
          ],
          'url': 'https://rickandmortyapi.com/api/character/1',
          'created': '2017-11-04T18:48:46.250Z',
          'origin': {'name': 'Earth (C-137)'},
          'location': {'name': 'Earth (Replacement Dimension)'}
        };

        when(mockHttpClient.get('character/1')).thenAnswer(
            (_) async => HttpResponse(data: mockResponse, statusCode: 200));

        final result = await repository.getCharacterById(1);

        expect(result.isRight(), isTrue);
        result.fold(
          (error) => fail('Should not return error'),
          (character) {
            expect(character, isA<Character>());
            expect(character.id, equals(1));
            expect(character.name, equals('Rick Sanchez'));
            expect(character.status, equals(LifeStatus.Alive));
          },
        );
      });

      test('should return error message when character not found', () async {
        when(mockHttpClient.get('character/999'))
            .thenThrow(HttpException(message: 'Not found', statusCode: 404));

        final result = await repository.getCharacterById(999);

        expect(result.isLeft(), isTrue);
        result.fold(
          (error) {
            expect(error, equals('Nenhum resultado encontrado'));
          },
          (character) => fail('Should not return success'),
        );
      });
    });

    group('searchCharactersByName', () {
      test('should return PaginatedResponse when search is successful',
          () async {
        final mockResponse = {
          'info': {'count': 1, 'pages': 1, 'next': null, 'prev': null},
          'results': [
            {
              'id': 1,
              'name': 'Rick Sanchez',
              'status': 'Alive',
              'species': 'Human',
              'type': '',
              'gender': 'Male',
              'image':
                  'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
              'episode': [],
              'url': 'https://rickandmortyapi.com/api/character/1',
              'created': '2017-11-04T18:48:46.250Z',
              'origin': {'name': 'Earth (C-137)'},
              'location': {'name': 'Earth (Replacement Dimension)'}
            }
          ]
        };

        when(mockHttpClient
                .get('character', queryParameters: {'name': 'Rick', 'page': 1}))
            .thenAnswer(
                (_) async => HttpResponse(data: mockResponse, statusCode: 200));

        final result = await repository.searchCharactersByName('Rick');

        expect(result.isRight(), isTrue);
        result.fold(
          (error) => fail('Should not return error'),
          (paginatedResponse) {
            expect(paginatedResponse, isA<PaginatedResponse<Character>>());
            expect(paginatedResponse.results.length, equals(1));
            expect(
                paginatedResponse.results.first.name, equals('Rick Sanchez'));
          },
        );
      });

      test('should return error message when search fails', () async {
        when(mockHttpClient.get('character',
                queryParameters: {'name': 'InvalidName', 'page': 1}))
            .thenThrow(HttpException(message: 'Not found', statusCode: 404));

        final result = await repository.searchCharactersByName('InvalidName');

        expect(result.isLeft(), isTrue);
        result.fold(
          (error) {
            expect(error, equals('Nenhum resultado encontrado'));
          },
          (response) => fail('Should not return success'),
        );
      });
    });

    group('getCharactersByIds', () {
      test(
          'should return List<Character> when API call is successful for single ID',
          () async {
        final mockResponse = {
          'id': 1,
          'name': 'Rick Sanchez',
          'status': 'Alive',
          'species': 'Human',
          'type': '',
          'gender': 'Male',
          'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
          'episode': [],
          'url': 'https://rickandmortyapi.com/api/character/1',
          'created': '2017-11-04T18:48:46.250Z',
          'origin': {'name': 'Earth (C-137)'},
          'location': {'name': 'Earth (Replacement Dimension)'}
        };

        when(mockHttpClient.get('character/1')).thenAnswer(
            (_) async => HttpResponse(data: mockResponse, statusCode: 200));

        final result = await repository.getCharactersByIds([1]);

        expect(result.isRight(), isTrue);
        result.fold(
          (error) => fail('Should not return error'),
          (characters) {
            expect(characters, isA<List<Character>>());
            expect(characters.length, equals(1));
            expect(characters.first.name, equals('Rick Sanchez'));
          },
        );
      });

      test(
          'should return List<Character> when API call is successful for multiple IDs',
          () async {
        final mockResponse = [
          {
            'id': 1,
            'name': 'Rick Sanchez',
            'status': 'Alive',
            'species': 'Human',
            'type': '',
            'gender': 'Male',
            'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
            'episode': [],
            'url': 'https://rickandmortyapi.com/api/character/1',
            'created': '2017-11-04T18:48:46.250Z',
            'origin': {'name': 'Earth (C-137)'},
            'location': {'name': 'Earth (Replacement Dimension)'}
          },
          {
            'id': 2,
            'name': 'Morty Smith',
            'status': 'Alive',
            'species': 'Human',
            'type': '',
            'gender': 'Male',
            'image': 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
            'episode': [],
            'url': 'https://rickandmortyapi.com/api/character/2',
            'created': '2017-11-04T18:48:46.250Z',
            'origin': {'name': 'Earth (C-137)'},
            'location': {'name': 'Earth (Replacement Dimension)'}
          }
        ];

        when(mockHttpClient.get('character/1,2')).thenAnswer(
            (_) async => HttpResponse(data: mockResponse, statusCode: 200));

        final result = await repository.getCharactersByIds([1, 2]);

        expect(result.isRight(), isTrue);
        result.fold(
          (error) => fail('Should not return error'),
          (characters) {
            expect(characters, isA<List<Character>>());
            expect(characters.length, equals(2));
            expect(characters[0].name, equals('Rick Sanchez'));
            expect(characters[1].name, equals('Morty Smith'));
          },
        );
      });

      test('should return error message when getCharactersByIds fails',
          () async {
        when(mockHttpClient.get('character/999'))
            .thenThrow(HttpException(message: 'Not found', statusCode: 404));

        final result = await repository.getCharactersByIds([999]);

        expect(result.isLeft(), isTrue);
        result.fold(
          (error) {
            expect(error, equals('Nenhum resultado encontrado'));
          },
          (characters) => fail('Should not return success'),
        );
      });
    });

    group('Error handling', () {
      test('should handle timeout errors correctly', () async {
        when(mockHttpClient.get('character', queryParameters: {'page': 1}))
            .thenThrow(HttpException(message: 'Timeout', statusCode: 408));

        final result = await repository.getCharacters();

        expect(result.isLeft(), isTrue);
        result.fold(
          (error) {
            expect(error, contains('Tempo limite excedido'));
          },
          (response) => fail('Should not return success'),
        );
      });

      test('should handle generic errors correctly', () async {
        when(mockHttpClient.get('character', queryParameters: {'page': 1}))
            .thenThrow(Exception('Generic error'));

        final result = await repository.getCharacters();

        expect(result.isLeft(), isTrue);
        result.fold(
          (error) {
            expect(error, contains('carregar personagens'));
          },
          (response) => fail('Should not return success'),
        );
      });
    });
  });
}
