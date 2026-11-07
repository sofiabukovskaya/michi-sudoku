import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:michi_mobile/features/scanner/application/scanner_image_source.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sudoku_scanner/sudoku_scanner.dart';

final class PlatformScannerImageSource implements ScannerImageSource {
  PlatformScannerImageSource({ImagePicker? picker})
    : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;
  CameraController? _controller;
  bool _requested = false;

  @override
  CameraController? get controller => _controller;

  @override
  Future<CameraAccess> openCamera() async {
    final status = await Permission.camera.status;
    if (status.isPermanentlyDenied || status.isRestricted) {
      return CameraAccess.settingsRequired;
    }
    if (!status.isGranted) {
      return _requested ? CameraAccess.denied : CameraAccess.notRequested;
    }
    return _initialize();
  }

  @override
  Future<CameraAccess> requestCamera() async {
    _requested = true;
    final status = await Permission.camera.request();
    if (status.isPermanentlyDenied || status.isRestricted) {
      return CameraAccess.settingsRequired;
    }
    if (!status.isGranted) return CameraAccess.denied;
    return _initialize();
  }

  Future<CameraAccess> _initialize() async {
    if (_controller?.value.isInitialized ?? false) return CameraAccess.granted;
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return CameraAccess.unavailable;
      final rear = cameras.where(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      );
      final selected = rear.isEmpty ? cameras.first : rear.first;
      final controller = CameraController(
        selected,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await controller.initialize();
      _controller = controller;
      return CameraAccess.granted;
    } on CameraException catch (error) {
      return switch (error.code) {
        'CameraAccessDeniedWithoutPrompt' => CameraAccess.settingsRequired,
        'CameraAccessDenied' => CameraAccess.denied,
        _ => CameraAccess.unavailable,
      };
    } on Object {
      return CameraAccess.unavailable;
    }
  }

  @override
  Future<ScanImage?> capture() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return null;
    final file = await controller.takePicture();
    try {
      return await _read(file);
    } finally {
      // Camera captures are temporary app-owned files, never library assets.
      try {
        await File(file.path).delete();
      } on FileSystemException {
        // The plugin may already have removed its temporary copy.
      }
    }
  }

  @override
  Future<ScanImage?> selectPhoto() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      requestFullMetadata: false,
    );
    return file == null ? null : _read(file);
  }

  Future<ScanImage> _read(XFile file) async {
    final bytes = await file.readAsBytes();
    if (bytes.length >= 3 && bytes[0] == 0xff && bytes[1] == 0xd8) {
      return ScanImage(bytes: bytes, format: ScanImageFormat.jpeg);
    }
    if (bytes.length >= 8 && bytes[0] == 0x89 && bytes[1] == 0x50) {
      return ScanImage(bytes: bytes, format: ScanImageFormat.png);
    }
    // The platform decoder can transcode supported HEIC/other library formats.
    try {
      final codec = await ui.instantiateImageCodec(Uint8List.fromList(bytes));
      final frame = await codec.getNextFrame();
      final png = await frame.image.toByteData(format: ui.ImageByteFormat.png);
      frame.image.dispose();
      codec.dispose();
      if (png == null) {
        throw const ScanFailure(ScanFailureKind.imageDecodeFailure);
      }
      return ScanImage(
        bytes: png.buffer.asUint8List(),
        format: ScanImageFormat.png,
      );
    } on Object {
      throw const ScanFailure(ScanFailureKind.imageDecodeFailure);
    }
  }

  @override
  Future<void> openSettings() async {
    await openAppSettings();
  }

  @override
  Future<void> closeCamera() async {
    final controller = _controller;
    _controller = null;
    await controller?.dispose();
  }
}
