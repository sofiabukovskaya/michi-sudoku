# Feature modules

Active Phase 1 route shells: splash, onboarding, auth, home, game, learn,
progress, profile and scanner. These have `presentation/` code only.

Future modules: coach, technique, practice, daily_challenge and settings.
Add `domain/` or `data/` only when a concrete use case or data source requires
it. The game feature will own stateful gameplay and coordinate the pure Dart
engine; the scanner feature will own review and validation of recognized cells.
