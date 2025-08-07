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
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(
              character: testCharacter,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Rick Sanchez'), findsOneWidget);
      expect(find.text('HUMAN'), findsOneWidget);
      expect(find.text('Male'), findsOneWidget);
    });

    testWidgets('should display correct status indicator for alive character',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(
              character: testCharacter,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Alive'), findsOneWidget);
      // Verificar se o indicador de status está presente
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('should display correct status indicator for dead character',
        (WidgetTester tester) async {
      // Arrange
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

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(
              character: deadCharacter,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Dead'), findsOneWidget);
    });

    testWidgets('should have InkWell for navigation',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(
              character: testCharacter,
            ),
          ),
        ),
      );

      // Assert
      // Verificar se o InkWell está presente para navegação
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('should display character image', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(
              character: testCharacter,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should handle character with empty type', (tester) async {
      // Arrange
      final characterWithEmptyType = Character(
          id: 3,
          name: 'Character with Empty Type',
          status: LifeStatus.Alive,
          species: 'Alien',
          type: '',
          gender: 'Female',
          image: 'https://example.com/image.jpg',
          episode: [],
          url: 'https://example.com/character/3',
          created: DateTime.now(),
          origin: 'Unknown',
          location: 'Unknown');

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(
              character: characterWithEmptyType,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Character with Empty Type'), findsOneWidget);
      expect(find.text('ALIEN'), findsOneWidget);
      expect(find.text('Female'), findsOneWidget);
    });

    testWidgets('should handle character with unknown status',
        (WidgetTester tester) async {
      // Arrange
      final unknownStatusCharacter = Character(
          id: 4,
          name: 'Unknown Status Character',
          status: LifeStatus.unknown,
          species: 'Human',
          type: '',
          gender: 'Male',
          image: 'https://example.com/image.jpg',
          episode: [],
          url: 'https://example.com/character/4',
          created: DateTime.now(),
          origin: 'Earth',
          location: 'Mars');

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(
              character: unknownStatusCharacter,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Unknown Status Character'), findsOneWidget);
      expect(find.text('unknown'), findsOneWidget);
    });
  });
}
