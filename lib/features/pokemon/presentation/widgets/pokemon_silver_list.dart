// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pokedex/shared/widgets/app_bar.dart';

class PokemonSilverList extends StatelessWidget {
  const PokemonSilverList({
    required this.children,
    this.scrollController,
    super.key,
  });

  final ScrollController? scrollController;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              const PokedexAppBar(),
              SliverList.list(
                children: children,
              )
            ],
          ),
        ),
      ],
    );
  }
}
