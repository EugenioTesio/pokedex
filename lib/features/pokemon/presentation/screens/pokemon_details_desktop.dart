// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/constants/sizes.dart';
import 'package:pokedex/features/pokemon/presentation/providers/pokemon_details_provider.dart';
import 'package:pokedex/shared/widgets/draggable_sheet_widget.dart';
import 'package:pokedex/shared/widgets/image_carousel.dart';
import 'package:pokedex/shared/widgets/no_image_placeholder.dart';
import 'package:pokedex/shared/widgets/responsive.dart';

class PokemonDetailsDesktop extends ConsumerWidget {
  const PokemonDetailsDesktop({
    required this.name,
    super.key,
  });

  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: Responsive.desktopBreakpoint.toDouble(),
        ),
        child: ref.watch(poekmonDetailsStateNotifierProvider(name)).when(
              data: (data) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: data.imageCacher != null
                            ? Image.memory(
                                data.imageCacher!.imageBytes,
                                fit: BoxFit.fitWidth,
                              )
                            : const NoImagePlaceholder(),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Row(
                          children: [
                            Padding(
                              padding: AppPaddings.padAll12,
                              child: IconButton(
                                onPressed: () {
                                  context.pop();
                                },
                                icon: const Icon(Icons.arrow_back),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: AppPaddings.padAll12,
                              child: IconButton(
                                onPressed: () {
                                  context.pop();
                                },
                                icon: const Icon(Icons.edit),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: DraggableSheetWidget(
                        child: Column(
                          children: [
                            //* Name
                            AppGaps.gapH20,
                            Text(
                              data.pokemonDetails?.name ?? '',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            AppGaps.gapH20,
                            //* Height
                            Text(
                              'Height: ${data.pokemonDetails?.height ?? ''}',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            //* Types Chips
                            AppGaps.gapH20,
                            if (data.pokemonDetails?.types != null) ...[
                              Text(
                                'Types',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              AppGaps.gapH20,
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: data.pokemonDetails!.types!
                                    .map(
                                      (e) => Chip(
                                        label: Text(e.type.name),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                            //* Abilities Chips
                            if (data.pokemonDetails?.abilities != null) ...[
                              AppGaps.gapH20,
                              Text(
                                'Abilities',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              AppGaps.gapH20,
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: data.pokemonDetails!.abilities!
                                    .map(
                                      (e) => e.ability != null
                                          ? Chip(
                                              label: Text(e.ability!.name),
                                            )
                                          : const SizedBox.shrink(),
                                    )
                                    .toList(),
                              ),
                            ],
                            //* Sprites Carousel
                            if (data.pokemonDetails?.sprites != null) ...[
                              AppGaps.gapH20,
                              Text(
                                'Sprites',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              AppGaps.gapH20,
                              ImageCarousel(
                                imageUrls:
                                    data.pokemonDetails!.sprites!.asList(),
                              )
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
      ),
    );
  }
}
