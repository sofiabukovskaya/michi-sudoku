import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/app/widgets/michi_mascot.dart';

void main() {
  test('mascot contexts resolve to distinct approved asset states', () {
    final paths = MichiMascotState.values.map(MichiMascot.assetFor).toList();
    expect(paths.toSet(), hasLength(paths.length));
    expect(MichiMascot.assetFor(MichiMascotState.calm), contains('calm'));
    expect(
      MichiMascot.assetFor(MichiMascotState.pointing),
      contains('pointing'),
    );
    expect(MichiMascot.assetFor(MichiMascotState.happy), contains('happy'));
    expect(
      MichiMascot.assetFor(MichiMascotState.notebook),
      contains('notebook'),
    );
    expect(
      MichiMascot.assetFor(MichiMascotState.celebrating),
      contains('completion_hero'),
    );
    expect(
      MichiMascot.assetFor(MichiMascotState.walking),
      contains('splash_mascot'),
    );
  });
}
