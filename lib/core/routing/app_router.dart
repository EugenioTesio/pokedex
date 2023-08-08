import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/routing/not_found_screen.dart';
import 'package:pokedex/features/pokemon/presentation/screens/pokemon_details_screen.dart';
import 'package:pokedex/features/pokemon/presentation/screens/pokemon_list_screen.dart';
import 'package:pokedex/features/splash_screen/presentation/splash_screen.dart';

enum AppRoute {
  pokemons,
  pokemonDetails,
  notFound,
  splash,
}

/// The [GoRouter] provider. Wrapped on a [Provider] to allow access to
/// other providers in the future.
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    errorBuilder: (context, state) => const NotFoundScreen(),
    initialLocation: '/pokemon',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/pokemons',
        name: AppRoute.pokemons.name,
        builder: (context, state) => const PokemonListScreen(),
        routes: [
          GoRoute(
            path: ':name',
            name: AppRoute.pokemonDetails.name,
            builder: (context, state) {
              final name = state.pathParameters['name']!;
              return PokemonDetailsScreen(name: name);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/not-found',
        name: AppRoute.notFound.name,
        builder: (context, state) => const NotFoundScreen(),
      ),
      GoRoute(
        path: '/splash',
        name: AppRoute.splash.name,
        builder: (context, state) => const SplashScreen(),
      ),
    ],
  );
});
