import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_design_system/michi_design_system.dart';

Widget _host(Widget child, {bool reduceMotion = false, bool ticking = true}) =>
    MediaQuery(
      data: MediaQueryData(disableAnimations: reduceMotion),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: TickerMode(enabled: ticking, child: Center(child: child)),
      ),
    );

double _opacityOfContent(WidgetTester tester) => tester
    .widget<Opacity>(
      find
          .descendant(
            of: find.byType(ExcludeSemantics),
            matching: find.byType(Opacity),
          )
          .first,
    )
    .opacity;

void main() {
  testWidgets('appears only after the delay, so instant loads never flash', (
    tester,
  ) async {
    await tester.pumpWidget(_host(const MichiPawLoader(label: 'Preparing')));
    expect(_opacityOfContent(tester), 0);
    await tester.pump(const Duration(milliseconds: 260));
    expect(_opacityOfContent(tester), 1);
    expect(find.text('Preparing'), findsOneWidget);
  });

  testWidgets('animates while loading, then rests and schedules no frames', (
    tester,
  ) async {
    await tester.pumpWidget(_host(const MichiPawLoader(label: 'Preparing')));
    await tester.pump(const Duration(milliseconds: 300));
    expect(tester.binding.hasScheduledFrame, isTrue);
    await tester.pump(const Duration(seconds: 13));
    await tester.pump();
    expect(tester.binding.hasScheduledFrame, isFalse);
  });

  testWidgets('Reduce Motion shows resting paws without a ticker', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        const MichiPawLoader(label: 'Preparing', delay: Duration.zero),
        reduceMotion: true,
      ),
    );
    await tester.pump();
    expect(tester.binding.hasScheduledFrame, isFalse);
  });

  testWidgets('a hidden screen draws no loader frames', (tester) async {
    await tester.pumpWidget(
      _host(
        const MichiPawLoader(label: 'Preparing', delay: Duration.zero),
        ticking: false,
      ),
    );
    await tester.pump();
    expect(tester.binding.hasScheduledFrame, isFalse);
  });

  testWidgets('is announced once by its label; paws are decorative', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      _host(
        const MichiPawLoader(
          label: 'Preparing your puzzle',
          showLabel: false,
          delay: Duration.zero,
        ),
        reduceMotion: true,
      ),
    );
    expect(
      tester.getSemantics(find.byType(MichiPawLoader)),
      matchesSemantics(label: 'Preparing your puzzle', isLiveRegion: true),
    );
    semantics.dispose();
  });
}
