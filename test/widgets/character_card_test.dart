import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ricky_and_martie_app/models/character.dart';
import 'package:ricky_and_martie_app/widgets/character_card.dart';

void main() {
  group('CharacterCard Widget Tests', () {
    late Character testCharacter;

    setUp(() {
      testCharacter = Character(
          id: 1,
          name: 'Rick Sanchez',
          status: LifeStatus.Alive,
          species: 'Human',
          type: '',
          gender: 'Male',
          image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
          episode: [
            'https://rickandmortyapi.com/api/episode/1',
            'https://rickandmortyapi.com/api/episode/2'
          ],
          url: 'https://rickandmortyapi.com/api/character/1',
          created: DateTime.now(),
          origin: 'Earth (C-137)',
          location: 'Earth (Replacement Dimension)');
    });

    testWidgets('should display character information correctly',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(
              character: testCharacter,
            ),
          ),
        ),
      );

      expect(find.text('Rick Sanchez'), findsOneWidget);
      expect(find.text('HUMAN'), findsOneWidget);
      expect(find.text('Male'), findsOneWidget);
    });

    testWidgets('should display correct status indicator for alive character',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(
              character: testCharacter,
            ),
          ),
        ),
      );

      expect(find.text('Alive'), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('should display correct status indicator for dead character',
        (tester) async {
      final deadCharacter = testCharacter.copyWith(
        id: 2,
        name: 'Dead Character',
        status: LifeStatus.Dead,
        image: 'https://example.com/image.jpg',
        episode: [],
        url: 'https://example.com/character/2',
        origin: 'Earth',
        location: 'Mars',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(
              character: deadCharacter,
            ),
          ),
        ),
      );

      expect(find.text('Dead'), findsOneWidget);
    });

    testWidgets('should have InkWell for navigation', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(
              character: testCharacter,
            ),
          ),
        ),
      );

      // Verificar se o InkWell está presente para navegação
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('should display character image', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(
              character: testCharacter,
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should handle character with empty type', (tester) async {
      final characterWithEmptyType = testCharacter.copyWith(
        id: 3,
        name: 'Character with Empty Type',
        species: 'Alien',
        gender: 'Female',
        image: 'https://example.com/image.jpg',
        episode: [],
        url: 'https://example.com/character/3',
        origin: 'Unknown',
        location: 'Unknown',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(
              character: characterWithEmptyType,
            ),
          ),
        ),
      );

      expect(find.text('Character with Empty Type'), findsOneWidget);
      expect(find.text('ALIEN'), findsOneWidget);
      expect(find.text('Female'), findsOneWidget);
    });

    testWidgets('should handle character with unknown status', (tester) async {
      final unknownStatusCharacter = testCharacter.copyWith(
        id: 4,
        name: 'Unknown Status Character',
        status: LifeStatus.unknown,
        image: 'https://example.com/image.jpg',
        episode: [],
        url: 'https://example.com/character/4',
        origin: 'Earth',
        location: 'Mars',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(
              character: unknownStatusCharacter,
            ),
          ),
        ),
      );

      expect(find.text('Unknown Status Character'), findsOneWidget);
      expect(find.text('unknown'), findsOneWidget);
    });
  });
}
