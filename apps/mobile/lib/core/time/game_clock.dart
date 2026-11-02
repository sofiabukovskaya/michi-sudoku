/// Wall time is needed across launches; monotonic time keeps a live timer
/// stable when the device clock is adjusted.
abstract interface class GameClock {
  DateTime now();

  Duration monotonic();
}

final class SystemGameClock implements GameClock {
  SystemGameClock() : _watch = Stopwatch()..start();

  final Stopwatch _watch;

  @override
  DateTime now() => DateTime.now().toUtc();

  @override
  Duration monotonic() => _watch.elapsed;
}
