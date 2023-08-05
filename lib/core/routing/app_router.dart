import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/routing/not_found_screen.dart';
import 'package:pokedex/features/pokemon/presentation/screens/pokemon_details_screen.dart';
import 'package:pokedex/features/pokemon/presentation/screens/pokemon_list_screen.dart';

enum AppRoute {
  pokemons,
  pokemonDetails,
  notFound,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    errorBuilder: (context, state) => const NotFoundScreen(),
    initialLocation: '/pokemons',
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
        path: 'not-found',
        name: AppRoute.notFound.name,
        builder: (context, state) => const NotFoundScreen(),
      ),
    ],
  );
});
