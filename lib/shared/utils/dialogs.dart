import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/shared/camera/presentation/camera_screen.dart';
import 'package:pokedex/shared/widgets/app_text.dart';

class AppDialogs {
  static Future<void> showCameraFullScreenDialog(
    BuildContext context,
    Function(Uint8List)? onPictureTaken,
  ) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      useRootNavigator: true,
      pageBuilder: (
        BuildContext buildContext,
        Animation animation,
        Animation secondaryAnimation,
      ) {
        return FutureBuilder<List<CameraDescription>>(
          future: availableCameras(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: AppText(
                  'Error: ${snapshot.error}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              );
            }
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.surface,
                  child: AppText(
                    'No cameras found',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              );
            }
            return Center(
              child: CameraScreen(
                cameras: snapshot.data!,
                onPictureTaken: onPictureTaken,
              ),
            );
          },
        );
      },
    );
  }
}
