import 'package:michi_mobile/features/puzzle/data/local_puzzle_catalog_loader.dart';

/// Parses the bundled catalog once in real time (setUpAll or runAsync), so
/// widget tests on fake time never wait on asset IO for thousands of
/// puzzles.
Future<void> warmPuzzleCatalog() => LocalPuzzleCatalogLoader().load();
