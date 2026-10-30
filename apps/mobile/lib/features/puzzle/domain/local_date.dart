import 'package:flutter/foundation.dart';

/// A local calendar day without a time or timezone offset.
@immutable
final class LocalDate {
  LocalDate(this.year, this.month, this.day) {
    final normalized = DateTime(year, month, day);
    if (normalized.year != year ||
        normalized.month != month ||
        normalized.day != day) {
      throw ArgumentError('Invalid calendar date.');
    }
  }

  factory LocalDate.fromDateTime(DateTime dateTime) {
    final local = dateTime.toLocal();
    return LocalDate(local.year, local.month, local.day);
  }

  factory LocalDate.parse(String source) {
    if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(source)) {
      throw FormatException('Invalid local date: $source');
    }
    return LocalDate(
      int.parse(source.substring(0, 4)),
      int.parse(source.substring(5, 7)),
      int.parse(source.substring(8, 10)),
    );
  }

  final int year;
  final int month;
  final int day;

  @override
  String toString() =>
      '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}-'
      '${day.toString().padLeft(2, '0')}';

  @override
  bool operator ==(Object other) =>
      other is LocalDate &&
      year == other.year &&
      month == other.month &&
      day == other.day;

  @override
  int get hashCode => Object.hash(year, month, day);
}
