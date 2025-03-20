part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

// ! Register States
class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {
  const RegisterSuccess({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

class RegisterError extends AuthState {
  const RegisterError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

// ! Login States
class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  const LoginSuccess({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

class LoginError extends AuthState {
  const LoginError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
// ! Logout States

class LogoutLoading extends AuthState {}

class LogoutSuccess extends AuthState {
  const LogoutSuccess({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

class LogoutError extends AuthState {
  const LogoutError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
