import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ricky_and_martie_app/models/character.dart';

void main() {
  group('Character Model Tests', () {
    test('should parse JSON correctly', () {
      final json = {
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

      final character = Character.fromJson(json);

      expect(character.id, equals(1));
      expect(character.name, equals('Rick Sanchez'));
      expect(character.status, equals(LifeStatus.Alive));
      expect(character.species, equals('Human'));
      expect(character.gender, equals('Male'));
      expect(character.origin, equals('Earth (C-137)'));
      expect(character.location, equals('Earth (Replacement Dimension)'));
      expect(character.episode.length, equals(2));
    });

    test('should handle unknown status correctly', () {
      final json = {
        'id': 1,
        'name': 'Test Character',
        'status': 'Unknown',
        'species': 'Human',
        'type': '',
        'gender': 'Male',
        'image': 'https://example.com/image.jpg',
        'episode': [],
        'url': 'https://example.com/character/1',
        'created': '2017-11-04T18:48:46.250Z',
        'origin': {'name': 'Earth'},
        'location': {'name': 'Mars'}
      };

      final character = Character.fromJson(json);

      expect(character.status, equals(LifeStatus.unknown));
    });

    test('should return correct status colors', () {
      final aliveCharacter = Character(
          id: 1,
          name: 'Alive Character',
          status: LifeStatus.Alive,
          species: 'Human',
          type: '',
          gender: 'Male',
          image: 'https://example.com/image.jpg',
          episode: [],
          url: 'https://example.com/character/1',
          created: DateTime.now(),
          origin: 'Earth',
          location: 'Mars');

      final deadCharacter = aliveCharacter.copyWith(
        status: LifeStatus.Dead,
      );

      final unknownCharacter = aliveCharacter.copyWith(
        status: LifeStatus.unknown,
      );

      expect(aliveCharacter.getStatusColor(), equals(Colors.green));
      expect(deadCharacter.getStatusColor(), equals(Colors.red));
      expect(unknownCharacter.getStatusColor(), equals(Colors.grey));
    });

    test('should handle empty origin and location', () {
      final json = {
        'id': 1,
        'name': 'Test Character',
        'status': 'Alive',
        'species': 'Human',
        'type': '',
        'gender': 'Male',
        'image': 'https://example.com/image.jpg',
        'episode': [],
        'url': 'https://example.com/character/1',
        'created': '2017-11-04T18:48:46.250Z',
        'origin': {'name': ''},
        'location': {'name': ''}
      };

      final character = Character.fromJson(json);

      expect(character.origin, equals(''));
      expect(character.location, equals(''));
    });

    test('should handle null origin and location', () {
      final json = {
        'id': 1,
        'name': 'Test Character',
        'status': 'Alive',
        'species': 'Human',
        'type': '',
        'gender': 'Male',
        'image': 'https://example.com/image.jpg',
        'episode': [],
        'url': 'https://example.com/character/1',
        'created': '2017-11-04T18:48:46.250Z',
        'origin': null,
        'location': null
      };

      final character = Character.fromJson(json);

      expect(character.origin, equals('Unknown'));
      expect(character.location, equals('Unknown'));
    });
  });
}
