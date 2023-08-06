import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_list.dart';
import 'package:pokedex/shared/widgets/app_text.dart';
import 'package:pokedex/shared/widgets/image_progress.dart';

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
    return Card(
      elevation: 10,
      shadowColor: Theme.of(context).colorScheme.tertiary,
      child: ListTile(
        onTap: () => onTap?.call(pokemonListItem),
        leading: Container(
          padding: const EdgeInsets.all(8),
          width: 50,
          height: 50,
          child: kIsWeb
              ? ImageNetwork(
                  image: parseUrlToPkparaisoImage(pokemonListItem.url),
                  width: 50,
                  height: 50,
                  onLoading: const ShimmerImageProgress(),
                  fitWeb: BoxFitWeb.scaleDown,
                  borderRadius: BorderRadius.circular(10),
                )
              : CachedNetworkImage(
                  imageUrl: pokemonListItem.url,
                  width: 50,
                  height: 50,
                  progressIndicatorBuilder: (context, url, progress) =>
                      const ShimmerImageProgress(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageBuilder: (context, imageProvider) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image(
                        image: imageProvider,
                        fit: BoxFit.scaleDown,
                      ),
                    );
                  },
                ),
        ),
        title: AppText(pokemonListItem.name),
      ),
    );
  }

  /// Parse the url to get the image from pkparaiso
  String parseUrlToPkparaisoImage(String url) {
    final regex = RegExp(r'\/(\d+)\/$');
    final match = regex.firstMatch(url);
    final number = int.parse(match?.group(1) ?? '');
    final numberString = number.toString().padLeft(3, '0');
    return 'https://www.pkparaiso.com/imagenes/pokedex/pokemon/$numberString.png';
  }
}
