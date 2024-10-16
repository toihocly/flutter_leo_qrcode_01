import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class AnalyzeImageFromGalleryButton extends StatelessWidget {
  const AnalyzeImageFromGalleryButton({required this.controller, super.key});

  final MobileScannerController controller;

  void uploadFile(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) {
      return;
    }

    final BarcodeCapture? barcodes = await controller.analyzeImage(
      image.path,
    );

    if (!context.mounted) {
      return;
    }

    final SnackBar snackbar = barcodes != null
        ? const SnackBar(
            content: Text('Barcode found!'),
            backgroundColor: Colors.green,
          )
        : const SnackBar(
            content: Text('No barcode found!'),
            backgroundColor: Colors.red,
          );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => uploadFile(context),
      child: Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: Colors.transparent),
        child: Icon(
          Icons.image,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    );
  }
}

class StartStopMobileScannerButton extends StatelessWidget {
  const StartStopMobileScannerButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return IconButton(
            color: Colors.white,
            icon: const Icon(Icons.play_arrow),
            iconSize: 32.0,
            onPressed: () async {
              await controller.start();
            },
          );
        }

        return IconButton(
          color: Colors.white,
          icon: const Icon(Icons.stop),
          iconSize: 32.0,
          onPressed: () async {
            await controller.stop();
          },
        );
      },
    );
  }
}

class SwitchCameraButton extends StatelessWidget {
  const SwitchCameraButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return const SizedBox.shrink();
        }

        final int? availableCameras = state.availableCameras;

        if (availableCameras != null && availableCameras < 2) {
          return const SizedBox.shrink();
        }

        final Widget icon;

        switch (state.cameraDirection) {
          case CameraFacing.front:
            icon = Icon(
              Icons.cameraswitch_rounded,
              color: Theme.of(context).colorScheme.onBackground,
            );
          case CameraFacing.back:
            icon = Icon(
              Icons.cameraswitch_rounded,
              color: Theme.of(context).colorScheme.onBackground,
            );
        }

        return GestureDetector(
          onTap: () async {
            await controller.switchCamera();
          },
          child: Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.transparent),
              child: icon),
        );
      },
    );
  }
}

class ToggleFlashlightButton extends StatelessWidget {
  const ToggleFlashlightButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return const SizedBox.shrink();
        }

        switch (state.torchState) {
          case TorchState.auto:
            return GestureDetector(
              onTap: () async {
                await controller.toggleTorch();
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.transparent),
                child: Icon(
                  Icons.flash_auto_rounded,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            );
          case TorchState.off:
            return GestureDetector(
              onTap: () async {
                await controller.toggleTorch();
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.transparent),
                child: Icon(
                  Icons.flashlight_off_rounded,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            );
          case TorchState.on:
            return GestureDetector(
              onTap: () async {
                await controller.toggleTorch();
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.transparent),
                child: Icon(
                  Icons.flashlight_on_rounded,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            );
          case TorchState.unavailable:
            return Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.transparent),
              child: Icon(
                Icons.no_flash_rounded,
                color: Theme.of(context).colorScheme.secondary,
              ),
            );
        }
      },
    );
  }
}
