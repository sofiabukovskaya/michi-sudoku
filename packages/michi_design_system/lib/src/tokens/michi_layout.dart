/// Window-size classes and page rhythm shared by every MICHI screen.
///
/// Layout adapts to the available window width, never to a device name.
/// Phone geometry is the approved design: text sits 24 from the edge,
/// cards and heroes 16. Larger windows keep that internal rhythm and add
/// outer whitespace around a readable column instead of stretching content.
abstract final class MichiLayout {
  /// Width at which a window stops being a phone layout.
  static const double mediumBreakpoint = 600;

  /// Width at which large-tablet / landscape margins apply.
  static const double expandedBreakpoint = 840;

  /// Card, hero and grouped-list gutter on phones.
  static const double cardGutter = 16;

  /// Extra inset for headings and loose text inside the card gutter.
  static const double textInset = 8;

  /// Readable column for content pages (Home, Progress, Learn, Profile).
  static const double readableWidth = 560;

  /// Narrower column for forms, onboarding and empty-state compositions.
  static const double focusedWidth = 480;

  /// Game and practice compositions bounded on tall tablets.
  static const double taskMaxHeight = 800;

  /// Spacing between page sections (approved 24–32).
  static const double sectionGap = 32;

  /// Gap between related elements.
  static const double elementGap = 16;

  /// Gap inside tightly related groups.
  static const double groupGap = 8;

  static MichiWindowClass classify(double width) => width >= expandedBreakpoint
      ? MichiWindowClass.expanded
      : width >= mediumBreakpoint
      ? MichiWindowClass.medium
      : MichiWindowClass.compact;

  /// Outer whitespace added around the readable column; zero on phones.
  static double outerMargin(double width) => switch (classify(width)) {
    MichiWindowClass.compact => 0,
    MichiWindowClass.medium => 32,
    MichiWindowClass.expanded => 48,
  };
}

enum MichiWindowClass { compact, medium, expanded }
