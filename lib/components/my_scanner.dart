import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_leo_qrcode_01/pages/my_scan_detail.dart';
import 'package:flutter_leo_qrcode_01/scanner_error_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'my_scanner_button_widgets.dart';

class MyScanner extends StatefulWidget {
  const MyScanner({super.key});

  @override
  State<MyScanner> createState() => _MyScannerState();
}

class _MyScannerState extends State<MyScanner> with WidgetsBindingObserver {
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    autoStart: false,
    torchEnabled: false,
    useNewCameraSelector: true,
  );

  Barcode? _barcode;
  // StreamSubscription<Object?>? _subscription;

  // Widget _buildBarcode(Barcode? value) {
  //   if (value == null) {
  //     return const Text(
  //       'Scan something!',
  //       overflow: TextOverflow.fade,
  //       style: TextStyle(color: Colors.white),
  //     );
  //   }

  //   return Text(
  //     value.displayValue ?? 'No display value.',
  //     overflow: TextOverflow.fade,
  //     style: const TextStyle(color: Colors.white),
  //   );
  // }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      // setState(() {
      //   _barcode = barcodes.barcodes.firstOrNull;
      // });

      print(barcodes);
      if (barcodes.barcodes.isNotEmpty) {
        controller.stop();
        print(barcodes.barcodes.first.displayValue);
        print(barcodes.barcodes.first.type);
        print(barcodes.barcodes.first.rawValue);

        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: MyScannerDetail(qrCodes: barcodes.barcodes),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        ).then((value) {
          controller.start();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // _subscription = controller.barcodes.listen(_handleBarcode);

    // unawaited(controller.start());
    controller.start();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (!controller.value.isInitialized) {
  //     return;
  //   }

  //   switch (state) {
  //     case AppLifecycleState.detached:
  //     case AppLifecycleState.hidden:
  //     case AppLifecycleState.paused:
  //       return;
  //     case AppLifecycleState.resumed:
  //       _subscription = controller.barcodes.listen(_handleBarcode);

  //       unawaited(controller.start());
  //     case AppLifecycleState.inactive:
  //       unawaited(_subscription?.cancel());
  //       _subscription = null;
  //       unawaited(controller.stop());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          onDetect: _handleBarcode,
          controller: controller,
          errorBuilder: (context, error, child) {
            return ScannerErrorWidget(error: error);
          },
          fit: BoxFit.contain,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            alignment: Alignment.bottomCenter,
            height: 100,
            // color: Colors.black.withOpacity(0.4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ToggleFlashlightButton(controller: controller),
                SwitchCameraButton(controller: controller),
                // AnalyzeImageFromGalleryButton(controller: controller),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // unawaited(_subscription?.cancel());
    // _subscription = null;
    super.dispose();
    controller.dispose();
  }
}
