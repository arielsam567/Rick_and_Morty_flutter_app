import 'package:go_router/go_router.dart';
import 'package:ricky_and_martie_app/pages/home/home_page.dart';
import 'package:ricky_and_martie_app/pages/details/details_page.dart';
import 'package:ricky_and_martie_app/widgets/erro_builder.dart';
import 'package:ricky_and_martie_app/models/character.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/details/:id',
        name: 'details',
        builder: (context, state) {
          final characterId = int.parse(state.pathParameters['id']!);
          // Por enquanto, vamos criar um personagem mock para teste
          // Em uma implementação real, você buscaria o personagem pelo ID
          final character = Character(
            id: characterId,
            name: 'Rick Sanchez',
            status: 'Alive',
            species: 'Human',
            type: '',
            gender: 'Male',
            image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
            episode: [
              'https://rickandmortyapi.com/api/episode/1',
              'https://rickandmortyapi.com/api/episode/2',
              'https://rickandmortyapi.com/api/episode/3',
            ],
            url: 'https://rickandmortyapi.com/api/character/1',
            created: DateTime.now(),
            origin: 'Earth (C-137)',
            location: 'Citadel of Ricks',
          );
          return DetailsPage(character: character);
        },
      ),
    ],
    errorBuilder: (context, state) => const ErroBuilder(),
  );
}
