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

// ! Change Password States
class ChangePasswordLoading extends AuthState {}

class ChangePasswordSuccess extends AuthState {
  const ChangePasswordSuccess({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

class ChangePasswordError extends AuthState {
  const ChangePasswordError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

// !   Profile States
class ProfileLoading extends AuthState {}

class ProfileSuccess extends AuthState {
  const ProfileSuccess({required this.profileModel});
  final ProfileModel profileModel;

  @override
  List<Object> get props => [profileModel];
}

class ProfileError extends AuthState {
  const ProfileError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
