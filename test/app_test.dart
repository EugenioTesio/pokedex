// BEGIN: abpxx6d04wxr
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app.dart';
import 'package:pokedex/features/pokemon/data/repositories/fake_pokemon_repository.dart';
import 'package:pokedex/features/pokemon/domain/providers/pokemon_providers.dart';
import 'package:pokedex/features/pokemon/presentation/screens/pokemon_list_screen.dart';
import 'package:pokedex/features/splash_screen/presentation/splash_screen.dart';
import 'package:pokedex/shared/analytics/data/repositories/fake_analytics_repository.dart';
import 'package:pokedex/shared/analytics/domain/providers/analytic_providers.dart';
import 'package:pokedex/shared/image_cacher/data/repositories/fake_image_cacher.dart';
import 'package:pokedex/shared/image_cacher/domain/providers/image_cacher_provider.dart';

void main() {
  testWidgets('App widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          imageCacherRepositoryProvider.overrideWithValue(
            FakeImageCacherRepository(),
          ),
          pokemonListRepositoryProvider.overrideWithValue(
            FakePokemonRepository(),
          ),
          analyticRepositoryProvider.overrideWithValue(
            FakeAnalyticsRepository(),
          ),
        ],
        child: const App(),
      ),
    );

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(PokemonListScreen), findsNothing);
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(seconds: 2));
    expect(find.byType(SplashScreen), findsNothing);
    expect(find.byType(PokemonListScreen), findsOneWidget);
  });
}
