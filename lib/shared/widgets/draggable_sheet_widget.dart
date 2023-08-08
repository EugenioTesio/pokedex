import 'package:flutter/material.dart';
import 'package:pokedex/core/constants/sizes.dart';

class DraggableSheetWidget extends StatelessWidget {
  const DraggableSheetWidget({
    this.child,
    super.key,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        minChildSize: 0.7,
        initialChildSize: 0.7,
        maxChildSize: 0.8,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            width: double.infinity,
            // Generic Designing of the sheet
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 20,
                  offset: const Offset(0, 5),
                  color: Colors.black.withOpacity(0.1),
                )
              ],
              color: Colors.white,
            ),
            // Contents of the sheet
            child: ListView(
              shrinkWrap: true,
              controller: scrollController,
              children: [
                AppGaps.gapH20,
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      height: 4,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                child ?? const SizedBox.shrink(),
              ],
            ),
          );
        },
      ),
    );
  }
}
