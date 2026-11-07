import 'package:camera/camera.dart';
import 'package:sudoku_scanner/sudoku_scanner.dart';

enum CameraAccess {
  notRequested,
  granted,
  denied,
  settingsRequired,
  unavailable,
}

/// Platform acquisition stays in mobile; scanner algorithms receive bytes.
abstract interface class ScannerImageSource {
  CameraController? get controller;

  Future<CameraAccess> openCamera();

  Future<CameraAccess> requestCamera();

  Future<ScanImage?> capture();

  Future<ScanImage?> selectPhoto();

  Future<void> openSettings();

  Future<void> closeCamera();
}
