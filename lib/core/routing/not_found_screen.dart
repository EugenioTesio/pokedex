import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/constants/sizes.dart';
import 'package:pokedex/core/routing/app_router.dart';
import 'package:pokedex/shared/widgets/app_text.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppText('404 - Page not found!'),
            AppGaps.gapH24,
            TextButton(
              onPressed: () => context.goNamed(AppRoute.pokemons.name),
              child: const AppText('Pokemons List'),
            )
          ],
        ),
      ),
    );
  }
}
