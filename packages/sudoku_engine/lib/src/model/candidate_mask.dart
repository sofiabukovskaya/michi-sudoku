import 'package:meta/meta.dart';

/// Immutable set of digits 1–9, with digit `d` stored in bit `d - 1`.
@immutable
final class CandidateMask {
  CandidateMask(int bits) : bits = _validBits(bits);

  const CandidateMask._(this.bits);

  factory CandidateMask.fromDigits(Iterable<int> digits) {
    var bits = 0;
    for (final digit in digits) {
      _checkDigit(digit);
      bits |= 1 << (digit - 1);
    }
    return CandidateMask._(bits);
  }

  static const int allBits = 0x1ff;
  static const CandidateMask empty = CandidateMask._(0);
  static const CandidateMask all = CandidateMask._(allBits);

  final int bits;

  bool contains(int digit) {
    _checkDigit(digit);
    return bits & (1 << (digit - 1)) != 0;
  }

  CandidateMask add(int digit) {
    _checkDigit(digit);
    return CandidateMask._(bits | (1 << (digit - 1)));
  }

  CandidateMask remove(int digit) {
    _checkDigit(digit);
    return CandidateMask._(bits & ~(1 << (digit - 1)));
  }

  /// Phase 1 names retained for existing callers.
  CandidateMask withDigit(int digit) => add(digit);

  CandidateMask withoutDigit(int digit) => remove(digit);

  CandidateMask union(CandidateMask other) =>
      CandidateMask._(bits | other.bits);

  CandidateMask intersection(CandidateMask other) =>
      CandidateMask._(bits & other.bits);

  CandidateMask difference(CandidateMask other) =>
      CandidateMask._(bits & ~other.bits);

  int get count {
    var remaining = bits;
    var result = 0;
    while (remaining != 0) {
      remaining &= remaining - 1;
      result++;
    }
    return result;
  }

  bool get isEmpty => bits == 0;

  bool get isSingle => bits != 0 && bits & (bits - 1) == 0;

  /// The only digit, or null when the mask has zero or multiple digits.
  int? get singleDigit {
    if (!isSingle) return null;
    for (var digit = 1; digit <= 9; digit++) {
      if (contains(digit)) return digit;
    }
    throw StateError('A single-bit candidate mask must contain a digit.');
  }

  /// Digits in ascending order.
  Iterable<int> get digits sync* {
    for (var digit = 1; digit <= 9; digit++) {
      if (contains(digit)) yield digit;
    }
  }

  static int _validBits(int bits) {
    RangeError.checkValueInInterval(bits, 0, allBits, 'bits');
    return bits;
  }

  static void _checkDigit(int digit) {
    RangeError.checkValueInInterval(digit, 1, 9, 'digit');
  }

  @override
  bool operator ==(Object other) =>
      other is CandidateMask && bits == other.bits;

  @override
  int get hashCode => bits.hashCode;

  @override
  String toString() => 'CandidateMask(${digits.join(', ')})';
}
