import 'package:meta/meta.dart';

/// Compact set of candidate digits; bit zero corresponds to digit 1.
@immutable
final class CandidateMask {
  CandidateMask(this.bits) {
    if (bits < 0 || bits > allBits) {
      throw RangeError.range(bits, 0, allBits, 'bits');
    }
  }

  static const int allBits = 0x1ff;
  final int bits;

  bool contains(int digit) {
    _checkDigit(digit);
    return bits & (1 << (digit - 1)) != 0;
  }

  CandidateMask withDigit(int digit) {
    _checkDigit(digit);
    return CandidateMask(bits | (1 << (digit - 1)));
  }

  CandidateMask withoutDigit(int digit) {
    _checkDigit(digit);
    return CandidateMask(bits & ~(1 << (digit - 1)));
  }

  static void _checkDigit(int digit) {
    if (digit < 1 || digit > 9) {
      throw RangeError.range(digit, 1, 9, 'digit');
    }
  }

  @override
  bool operator ==(Object other) =>
      other is CandidateMask && bits == other.bits;

  @override
  int get hashCode => bits.hashCode;
}
