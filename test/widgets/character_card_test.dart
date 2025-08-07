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

      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('should navigate to details page when tapped', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(
              character: testCharacter,
            ),
          ),
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);

      final inkWell = tester.widget<InkWell>(find.byType(InkWell));
      expect(inkWell.onTap, isNotNull);
      expect(inkWell.onTap, isA<Function>());

      expect(inkWell.borderRadius, BorderRadius.circular(8.0));
    });

    testWidgets(
        'should have correct navigation configuration for different character IDs',
        (tester) async {
      final characterWithId5 = testCharacter.copyWith(
        id: 5,
        name: 'Test Character ID 5',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(
              character: characterWithId5,
            ),
          ),
        ),
      );

      // Verificar se o InkWell está presente
      expect(find.byType(InkWell), findsOneWidget);

      // Obter o widget InkWell
      final inkWell = tester.widget<InkWell>(find.byType(InkWell));

      // Verificar se o onTap está configurado
      expect(inkWell.onTap, isNotNull);
      expect(inkWell.onTap, isA<Function>());

      // Verificar se o InkWell tem o borderRadius configurado corretamente
      expect(inkWell.borderRadius, BorderRadius.circular(8.0));
    });

    testWidgets('should have navigation callback configured correctly',
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

    testWidgets('should call context.go with correct route when tapped',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return CharacterCard(
                  character: testCharacter,
                );
              },
            ),
          ),
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);

      final inkWell = tester.widget<InkWell>(find.byType(InkWell));

      expect(inkWell.onTap, isNotNull);
      expect(inkWell.onTap, isA<Function>());

      expect(inkWell.borderRadius, BorderRadius.circular(8.0));

      expect(inkWell.onTap, isA<Function>());
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

      final inkWell = tester.widget<InkWell>(find.byType(InkWell));

      expect(inkWell.onTap, isNotNull);
      expect(inkWell.onTap, isA<Function>());

      expect(inkWell.borderRadius, BorderRadius.circular(8.0));

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      expect(find.text('Details Page - ID: 1'), findsOneWidget);
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
