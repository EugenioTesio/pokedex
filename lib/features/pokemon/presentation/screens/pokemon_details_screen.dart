import 'package:flutter/material.dart';
import 'package:pokedex/shared/widgets/responsive.dart';

class PokemonDetailsScreen extends StatelessWidget {
  const PokemonDetailsScreen({
    required this.name,
    super.key,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Responsive(
      desktop: Container(),
      mobile: Container(),
    );
  }
}
