import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:shimmer/shimmer.dart';

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
      leading: CachedNetworkImage(
        imageUrl: pokemonListItem.url,
        width: 50,
        height: 50,
        progressIndicatorBuilder: (context, url, progress) =>
            Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.white,
          child: const SizedBox.expand(
            child: Icon(Icons.image),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        placeholder: (context, url) => const Icon(Icons.image),
      ),
      title: Text(pokemonListItem.name),
    );
  }
}