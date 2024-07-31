part of 'signin_bloc.dart';

@immutable
sealed class SigninEvent {}


class OnSigninButtonClickedEvent extends SigninEvent{
  final String email;
  final String passowrd;

  OnSigninButtonClickedEvent({required this.email, required this.passowrd});
}

class OnGoogleSignInButtonClickedEvent extends SigninEvent {}