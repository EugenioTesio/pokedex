import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';

class PokemonListItemCard extends StatelessWidget {
  const PokemonListItemCard({
    required this.pokemonListItem,
    required this.onTap,
    super.key,
  });

  final PokemonListItem pokemonListItem;
  final Function(PokemonListItem)? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap?.call(pokemonListItem),
      leading: Image.network(
        pokemonListItem.url,
        width: 50,
        height: 50,
        loadingBuilder: (context, child, loadingProgress) =>
            const CircularProgressIndicator(),
      ),
      title: Text(pokemonListItem.name),
    );
  }
}
