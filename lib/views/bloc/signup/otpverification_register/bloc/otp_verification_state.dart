part of 'otp_verification_bloc.dart';

@immutable
sealed class OtpVerificationState {}

final class OtpVerificationInitial extends OtpVerificationState {}

final class OtpVerificationSuccessState extends OtpVerificationState{}

final class OtpVerificationLoadinState extends OtpVerificationState{}

final class OtpVerificationErroState extends OtpVerificationState{
  final String error;

  OtpVerificationErroState({required this.error});

  
}