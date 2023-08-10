import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/shared/camera/presentation/widgets/preview_widget.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    required this.cameras,
    required this.onPictureTaken,
    super.key,
  });

  final List<CameraDescription> cameras;
  final void Function(XFile picture)? onPictureTaken;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late XFile? _picture;
  bool _isRearCameraSelected = true;
  bool _showPreview = false;

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras[0]);
  }

  Future takePicture() async {
    if (!_cameraController.value.isInitialized) {
      debugPrint('Camera is not initialized');
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      debugPrint('Camera is already taking a picture');
      return null;
    }
    try {
      //await _cameraController.setFlashMode(FlashMode.off);
      _picture = await _cameraController.takePicture();
      _showPreview = true;
      setState(() {});
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint('camera error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _showPreview
            ? PreviewWidget(
                picture: _picture!,
                onAccept: () {
                  widget.onPictureTaken?.call(_picture!);
                  context.pop();
                },
                onReject: () => context.pop(),
              )
            : Stack(
                children: [
                  if (_cameraController.value.isInitialized)
                    CameraPreview(_cameraController)
                  else
                    const ColoredBox(
                      color: Colors.black,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.20,
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24)),
                        color: Colors.black,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              iconSize: 30,
                              icon: Icon(
                                _isRearCameraSelected
                                    ? Icons.camera_rear
                                    : Icons.camera_front,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(
                                  () => _isRearCameraSelected =
                                      !_isRearCameraSelected,
                                );
                                initCamera(
                                  widget.cameras[_isRearCameraSelected ? 0 : 1],
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              onPressed: takePicture,
                              iconSize: 50,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon:
                                  const Icon(Icons.circle, color: Colors.white),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
