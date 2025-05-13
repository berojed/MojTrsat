sealed class AuthFailure {
  final String message;
  const AuthFailure(this.message);
}

class NetworkFailure extends AuthFailure {
  const NetworkFailure() : super('Network error.');
}

class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure() : super('Invalid email or password.');
}

class UnknownFailure extends AuthFailure {
  const UnknownFailure([String? msg]) : super(msg ?? 'Unknown error.');
}