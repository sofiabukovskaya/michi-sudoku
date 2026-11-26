import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/warm_puzzle_catalog.dart';
import '../lifecycle_driver.dart';

/// Usage: an unfinished local game with entries and notes
Future<void> anUnfinishedLocalGameWithEntriesAndNotes(
  WidgetTester tester,
) async {
  await tester.runAsync(warmPuzzleCatalog);
  LifecycleDriver.current = LifecycleDriver.create(tester);
  await LifecycleDriver.current!.prepareSavedGame();
}
