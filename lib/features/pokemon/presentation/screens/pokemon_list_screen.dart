import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/presentation/screens/pokemon_list_desktop.dart';
import 'package:pokedex/shared/widgets/responsive.dart';

class PokemonListScreen extends StatelessWidget {
  const PokemonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Responsive(
        desktop: PokemonListDesktop(),
      ),
    );
  }
}
