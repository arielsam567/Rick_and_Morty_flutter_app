import 'package:go_router/go_router.dart';
import 'package:ricky_and_martie_app/pages/home/home_page.dart';
import 'package:ricky_and_martie_app/pages/details/details_page.dart';
import 'package:ricky_and_martie_app/widgets/erro_builder.dart';

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
          return DetailsPage(characterId: characterId);
        },
      ),
    ],
    errorBuilder: (context, state) => const ErroBuilder(),
  );
}
