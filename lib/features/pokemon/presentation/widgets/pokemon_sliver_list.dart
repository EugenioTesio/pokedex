// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pokedex/core/constants/sizes.dart';

class PokemonSliverList extends StatelessWidget {
  const PokemonSliverList({
    required this.children,
    required this.showLoading,
    required this.sliverAppBar,
    required this.resultsCount,
    this.scrollController,
    this.onLastIndexFetched,
    this.onItemBuilt,
    this.columns = 1,
    super.key,
  });

  final ScrollController? scrollController;
  final List<Widget> children;
  final bool showLoading;
  final int resultsCount;
  final VoidCallback? onLastIndexFetched;
  final void Function(int index)? onItemBuilt;
  final Widget sliverAppBar;
  final int columns;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              sliverAppBar,
              const SliverToBoxAdapter(
                child: AppGaps.gapH12,
              ),
              SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 300,
                  childAspectRatio: 2,
                ),
                itemCount: children.length + (showLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  //* Last item logic
                  if (index == children.length - 1 &&
                      children.length != resultsCount) {
                    onLastIndexFetched?.call();
                  }

                  //* Loading logic
                  if (index == children.length) {
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  onItemBuilt?.call(index);

                  //* Normal logic
                  return children[index];
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
