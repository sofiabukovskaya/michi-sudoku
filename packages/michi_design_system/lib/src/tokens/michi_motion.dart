import 'package:flutter/animation.dart';

abstract final class MichiMotion {
  static const quick = Duration(milliseconds: 150);
  static const standard = Duration(milliseconds: 200);
  static const enter = Duration(milliseconds: 260);
  static const emphasis = Duration(milliseconds: 300);
  static const reduced = Duration(milliseconds: 100);
  static const curve = Cubic(0.2, 0, 0, 1);
}
