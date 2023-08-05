import 'package:flutter/material.dart';
import 'package:pokedex/shared/widgets/responsive.dart';

class PokemonDetailsScreen extends StatelessWidget {
  const PokemonDetailsScreen({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Responsive(
      desktop: Container(),
      mobile: Container(),
    );
  }
}
