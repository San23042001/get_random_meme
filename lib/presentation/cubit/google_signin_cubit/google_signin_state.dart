part of 'google_signin_cubit.dart';

sealed class GoogleSigninState extends Equatable {
  const GoogleSigninState();

  @override
  List<Object> get props => [];
}

final class GoogleSigninInitial extends GoogleSigninState {}

class GoogleSigninLoading extends GoogleSigninState {
  @override
  List<Object> get props => [];
}

class GoogleSigninSuccess extends GoogleSigninState {
  final User user;

  const GoogleSigninSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class GoogleSignOutSuccess extends GoogleSigninState {
  @override
  List<Object> get props => [];
}

class GoogleSigninError extends GoogleSigninState {
  final AppError error;

  const GoogleSigninError(this.error);
  @override
  List<Object> get props => [error];
}