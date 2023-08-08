// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/constants/sizes.dart';
import 'package:pokedex/core/constants/theme.dart';
import 'package:pokedex/features/pokemon/presentation/providers/pokemon_providers.dart';
import 'package:pokedex/shared/utils/dialogs.dart';
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
                        child: Padding(
                          padding: AppPaddings.padAll16,
                          child: data.imageCacher != null
                              ? Image.memory(
                                  data.imageCacher!.imageBytes,
                                  fit: BoxFit.fitWidth,
                                  scale: 0.4,
                                )
                              : const NoImagePlaceholder(),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SafeArea(
                          child: Row(
                            children: [
                              Padding(
                                padding: AppPaddings.padTop20Left10,
                                child: IconButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  icon: const Icon(Icons.arrow_back),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: AppPaddings.padTop20right10,
                                child: IconButton(
                                  onPressed: () {
                                    AppDialogs.showCameraFullScreenDialog(
                                      context,
                                      (picture) => _saveImage(
                                        picture,
                                        ref,
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                              ),
                            ],
                          ),
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
                              data.pokemonDetails?.name.toUpperCase() ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    letterSpacing: 4,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            AppGaps.gapH20,
                            //* Height
                            Text(
                              'Height: ${data.pokemonDetails?.height ?? ''}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    letterSpacing: 3,
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                            ),
                            //* Types Chips
                            AppGaps.gapH20,
                            if (data.pokemonDetails?.types != null) ...[
                              Text(
                                'Types',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      letterSpacing: 2,
                                      fontFamily: AppFontFamilies.pokemonHollow,
                                      fontWeight: FontWeight.w600,
                                    ),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      letterSpacing: 2,
                                      fontFamily: AppFontFamilies.pokemonHollow,
                                      fontWeight: FontWeight.w600,
                                    ),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      letterSpacing: 2,
                                      fontFamily: AppFontFamilies.pokemonHollow,
                                      fontWeight: FontWeight.w600,
                                    ),
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

  Future<void> _saveImage(
    XFile picture,
    WidgetRef ref,
  ) async {
    final bytes = await picture.readAsBytes();
    await ref
        .read(poekmonDetailsStateNotifierProvider(name).notifier)
        .saveImage(name, bytes);
  }
}
