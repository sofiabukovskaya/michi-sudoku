final class AuthAccount {
  const AuthAccount({
    required this.uid,
    required this.emailVerified,
    this.email,
    this.displayName,
  });

  final String uid;
  final String? email;
  final String? displayName;
  final bool emailVerified;
}
