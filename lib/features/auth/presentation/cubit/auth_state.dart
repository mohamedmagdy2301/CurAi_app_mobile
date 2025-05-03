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

// !  Get Profile States
class GetProfileLoading extends AuthState {}

class GetProfileSuccess extends AuthState {
  const GetProfileSuccess({required this.profileModel});
  final ProfileModel profileModel;

  @override
  List<Object> get props => [profileModel];
}

class GetProfileError extends AuthState {
  const GetProfileError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

// ! Edit Profile States
class EditProfileLoading extends AuthState {}

class EditProfileSuccess extends AuthState {
  const EditProfileSuccess({required this.message, required this.profileModel});
  final ProfileModel profileModel;
  final String message;

  @override
  List<Object> get props => [profileModel];
}

class EditProfileError extends AuthState {
  const EditProfileError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
} // ! Edit Photo Profile States

class EditPhotoProfileLoading extends AuthState {}

class EditPhotoProfileSuccess extends AuthState {
  const EditPhotoProfileSuccess({required this.profileModel});
  final ProfileModel profileModel;

  @override
  List<Object> get props => [profileModel];
}

class EditPhotoProfileError extends AuthState {
  const EditPhotoProfileError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

// ! Contact Us States
class ContactUsLoading extends AuthState {}

class ContactUsSuccess extends AuthState {
  const ContactUsSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class ContactUsError extends AuthState {
  const ContactUsError({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}
