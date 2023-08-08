import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/core/constants/sizes.dart';

class PreviewWidget extends StatelessWidget {
  const PreviewWidget({
    required this.picture,
    required this.onAccept,
    required this.onReject,
    super.key,
  });

  final XFile picture;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.file(
            File(picture.path),
            fit: BoxFit.cover,
            width: 250,
          ),
          AppGaps.gapH24,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: onReject,
                icon: const Icon(Icons.close),
              ),
              AppGaps.gapW24,
              IconButton(
                onPressed: onAccept,
                icon: const Icon(Icons.check),
              ),
            ],
          )
        ],
      ),
    );
  }
}
