import 'package:flutter/material.dart';
import 'package:pokedex/core/constants/sizes.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_list.dart';
import 'package:pokedex/shared/image_cacher/presentation/image_cacher_widget.dart';
import 'package:pokedex/shared/widgets/app_text.dart';

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
    final (imageKey, imageUrl) = getKeyAndUrlToPkparaisoImage(
      pokemonListItem.url,
    );
    return SizedBox(
      width: 300,
      height: 200,
      child: Card(
        elevation: 4,
        shadowColor: Theme.of(context).colorScheme.tertiary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageCacherWidget(
                  width: 150,
                  height: 150,
                  imageUrl: imageUrl,
                  imageKey: imageKey,
                ),
                AppGaps.gapH8,
                AppText(
                  pokemonListItem.name,
                  maxLines: 2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Parse the url to get the image from pkparaiso
  (String key, String url) getKeyAndUrlToPkparaisoImage(String url) {
    final regex = RegExp(r'\/(\d+)\/$');
    final match = regex.firstMatch(url);
    final number = int.parse(match?.group(1) ?? '');

    //! Changed to raw.githubusercontent.com due to pkparaiso.com CORS policy
    //! https://github.com/flutter/flutter/issues/119297
    return (
      number.toString(),
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$number.png',
    );
  }
}
