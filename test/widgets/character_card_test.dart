import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
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
      expect(find.text('Alive'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets(
        'should display correct status indicators for different statuses',
        (tester) async {
      // Teste para personagem morto
      final deadCharacter = testCharacter.copyWith(
        id: 2,
        name: 'Dead Character',
        status: LifeStatus.Dead,
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

      // Teste para personagem com status desconhecido
      final unknownStatusCharacter = testCharacter.copyWith(
        id: 4,
        name: 'Unknown Status Character',
        status: LifeStatus.unknown,
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

      expect(find.text('unknown'), findsOneWidget);
    });

    testWidgets('should have proper InkWell configuration for navigation',
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

      final inkWell = tester.widget<InkWell>(find.byType(InkWell));
      expect(inkWell.onTap, isNotNull);
      expect(inkWell.onTap, isA<Function>());
      expect(inkWell.borderRadius, BorderRadius.circular(8.0));
    });

    testWidgets('should handle character with empty type', (tester) async {
      final characterWithEmptyType = testCharacter.copyWith(
        id: 3,
        name: 'Character with Empty Type',
        species: 'Alien',
        gender: 'Female',
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

    testWidgets('should navigate to correct details route with character ID',
        (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => Scaffold(
              body: CharacterCard(character: testCharacter),
            ),
          ),
          GoRoute(
            path: '/details/:id',
            builder: (context, state) => Scaffold(
              body: Text('Details Page - ID: ${state.pathParameters['id']}'),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      expect(find.byType(CharacterCard), findsOneWidget);
      expect(find.byType(InkWell), findsOneWidget);

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      expect(find.text('Details Page - ID: 1'), findsOneWidget);
    });
  });
}
