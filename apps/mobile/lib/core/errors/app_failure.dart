/// Small application-level error vocabulary. Package errors stay in packages.
sealed class AppFailure {
  const AppFailure(this.message);

  final String message;
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure(super.message);
}

final class StorageFailure extends AppFailure {
  const StorageFailure(super.message);
}

final class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure(super.message);
}
