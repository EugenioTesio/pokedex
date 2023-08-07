// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PokemonSliverList extends StatelessWidget {
  const PokemonSliverList({
    required this.children,
    required this.showLoading,
    required this.sliverAppBar,
    required this.resultsCount,
    this.scrollController,
    this.onLastIndexFetched,
    this.onItemBuilt,
    super.key,
  });

  final ScrollController? scrollController;
  final List<Widget> children;
  final bool showLoading;
  final int resultsCount;
  final VoidCallback? onLastIndexFetched;
  final void Function(int index)? onItemBuilt;
  final Widget sliverAppBar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              sliverAppBar,
              SliverList.builder(
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
