import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ricky_and_martie_app/models/character.dart';

void main() {
  group('Character Model Tests', () {
    test('should create Character from valid JSON', () {
      // Arrange
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

      // Act
      final character = Character.fromJson(json);

      // Assert
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
      // Arrange
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

      // Act
      final character = Character.fromJson(json);

      // Assert
      expect(character.status, equals(LifeStatus.unknown));
    });

    test('should return correct status colors', () {
      // Arrange
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

      final deadCharacter = Character(
          id: 2,
          name: 'Dead Character',
          status: LifeStatus.Dead,
          species: 'Human',
          type: '',
          gender: 'Male',
          image: 'https://example.com/image.jpg',
          episode: [],
          url: 'https://example.com/character/2',
          created: DateTime.now(),
          origin: 'Earth',
          location: 'Mars');

      final unknownCharacter = Character(
          id: 3,
          name: 'Unknown Character',
          status: LifeStatus.unknown,
          species: 'Human',
          type: '',
          gender: 'Male',
          image: 'https://example.com/image.jpg',
          episode: [],
          url: 'https://example.com/character/3',
          created: DateTime.now(),
          origin: 'Earth',
          location: 'Mars');

      // Act & Assert
      expect(aliveCharacter.getStatusColor(), equals(Colors.green));
      expect(deadCharacter.getStatusColor(), equals(Colors.red));
      expect(unknownCharacter.getStatusColor(), equals(Colors.grey));
    });

    test('should handle missing origin and location names', () {
      // Arrange
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
        'origin': {},
        'location': {}
      };

      // Act
      final character = Character.fromJson(json);

      // Assert
      expect(character.origin, equals('Unknown'));
      expect(character.location, equals('Unknown'));
    });

    test('should handle null origin and location', () {
      // Arrange
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
        'origin': {},
        'location': {}
      };

      // Act
      final character = Character.fromJson(json);

      // Assert
      expect(character.origin, equals('Unknown'));
      expect(character.location, equals('Unknown'));
    });
  });
}
