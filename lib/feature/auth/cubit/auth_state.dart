part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthUnauthenticated extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthAuthenticated extends AuthState {}

final class AuthLogOut extends AuthState {}

final class AuthError extends AuthState {
  final String err;

  const AuthError({required this.err});
  @override
  List<Object> get props => [err];
}
