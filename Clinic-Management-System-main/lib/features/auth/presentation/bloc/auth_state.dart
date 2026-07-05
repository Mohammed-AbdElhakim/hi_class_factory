part of 'auth_bloc.dart';

abstract class AuthState {
  const AuthState();

  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(User user)? authenticated,
    R Function()? unauthenticated,
    R Function(String message)? error,
  }) {
    if (this is _Initial) return initial?.call();
    if (this is _Loading) return loading?.call();
    if (this is _Authenticated) {
      return authenticated?.call((this as _Authenticated).user);
    }
    if (this is _Unauthenticated) return unauthenticated?.call();
    if (this is _Error) return error?.call((this as _Error).message);
    return null;
  }

  R maybeWhen<R>({
    required R Function() orElse,
    R Function()? initial,
    R Function()? loading,
    R Function(User user)? authenticated,
    R Function()? unauthenticated,
    R Function(String message)? error,
  }) {
    if (this is _Initial && initial != null) return initial();
    if (this is _Loading && loading != null) return loading();
    if (this is _Authenticated && authenticated != null) {
      return authenticated((this as _Authenticated).user);
    }
    if (this is _Unauthenticated && unauthenticated != null) return unauthenticated();
    if (this is _Error && error != null) return error((this as _Error).message);
    return orElse();
  }
}

class _Initial extends AuthState {
  const _Initial();
}

class _Loading extends AuthState {
  const _Loading();
}

class _Authenticated extends AuthState {
  final User user;

  const _Authenticated(this.user);
}

class _Unauthenticated extends AuthState {
  const _Unauthenticated();
}

class _Error extends AuthState {
  final String message;

  const _Error(this.message);
}

extension AuthStateFactory on AuthState {
  static const AuthState initial = _Initial();
  static const AuthState loading = _Loading();
  static AuthState authenticated(User user) => _Authenticated(user);
  static const AuthState unauthenticated = _Unauthenticated();
  static AuthState error(String message) => _Error(message);
}
