part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpSuccesState extends SignUpState{}

final class SignUpLoadingState extends SignUpState{}

final class signUpErrorState extends SignUpState{
  final String error;
  signUpErrorState({required this.error});
}

