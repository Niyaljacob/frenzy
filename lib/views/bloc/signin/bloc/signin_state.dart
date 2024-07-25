part of 'signin_bloc.dart';

@immutable
sealed class SigninState {}

final class SigninInitial extends SigninState {}

final class SigninSuccesState extends SigninState {}

final class SigninLoadingState extends SigninState {}


final class SigninErrorState extends SigninState {
  final String error;

  SigninErrorState({required this.error});
}
