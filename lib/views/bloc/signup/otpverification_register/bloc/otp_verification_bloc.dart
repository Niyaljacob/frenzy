import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:frenzy/repository/authentication/authentication_repo.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'otp_verification_event.dart';
part 'otp_verification_state.dart';

class OtpVerificationBloc extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  OtpVerificationBloc() : super(OtpVerificationInitial()) {
    on<OnOtpVerifyButtonClicked>((event, emit) async{
      emit(OtpVerificationLoadinState());
      var response =await AuthenticationRepository.verifyOtp(event.email, event.otp);
      if(response != null && response.statusCode==200){
        return emit(OtpVerificationSuccessState());
      }else if (response != null){
        final responseData = jsonDecode(response.body);
        return emit(OtpVerificationErroState(error: responseData["message"]));
      }else{
        return emit(OtpVerificationErroState(error: "Something went wrong"));
      }
    });
  }
}
