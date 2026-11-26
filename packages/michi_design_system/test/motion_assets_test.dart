import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:michi_design_system/michi_design_system.dart';

/// Expected timelines from the Motion Library V2.1 README.
const Map<MichiMotionAsset, Duration> _expected = {
  MichiMotionAsset.idle: Duration(milliseconds: 5000),
  MichiMotionAsset.thinking: Duration(milliseconds: 2400),
  MichiMotionAsset.happy: Duration(milliseconds: 1400),
  MichiMotionAsset.celebrating: Duration(milliseconds: 1800),
  MichiMotionAsset.dailyStamp: Duration(milliseconds: 900),
};

void main() {
  for (final asset in MichiMotionAsset.values) {
    test('${asset.name} parses in the Flutter Lottie runtime', () async {
      final bytes = File(asset.path).readAsBytesSync();
      final composition = await LottieComposition.fromBytes(bytes);
      expect(composition.duration, _expected[asset]);
      expect(composition.startFrame, 0);
      expect(composition.frameRate, 60);
      expect(composition.bounds.width, 640);
      expect(composition.bounds.height, 640);
      expect(composition.images, isEmpty);
      expect(composition.warnings, isEmpty);
    });
  }
}
