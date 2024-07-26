import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:frenzy/repository/authentication/authentication_repo.dart';
import 'package:frenzy/views/bloc/forgot_password_bloc/bloc/forgotpassword_event.dart';
import 'package:frenzy/views/bloc/forgot_password_bloc/bloc/forgotpassword_state.dart';



class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<OnForgotPassLoginButtonClicked>((event, emit) async{
      emit(ForgotPasswordLoadingState());
      var response = await AuthenticationRepository.resetPasswordOtp(event.email);
      if(response!=null && response.statusCode==200){
        var responseBody=jsonDecode(response.body);
        if(responseBody["status"]==200){
          return emit(ForgotPasswordSuccesState());
        }else{
          
          return emit (ForgotPasswordErrorState(error: responseBody["message"]));
        }
      }else{
        return emit(ForgotPasswordErrorState(error: 'Something wet wrong'));
      }
    });

    on<OnVerifyButtonClickedEvent>((event, emit)async{
      emit(OtpverifiedLoadingState());
      var response = await AuthenticationRepository.verifyOtpPasswordReset(
        event.email, event.otp);
        if(response!=null && response.statusCode==200){
          var responseBody=jsonDecode(response.body);
          if(responseBody["status"]){
            return emit(OtpverifiedSuccesState());
          }else{
            if(kDebugMode){
              print(responseBody);
            }
            return emit(OtpverifiedErrorState(error: 'Invalid Otp'));
          }
        }else{
          return emit(OtpverifiedErrorState(error: 'Somthing went wrong'));
        }
    });

    on<OnResetPasswordButtonClickedEvent>((event, emit)async{
      emit(ResetPasswordSuccesState());
      var response=await AuthenticationRepository.passwordUpdate(event.email, event.password);
      if(response!=null && response.statusCode==200){
        return emit(ResetPasswordSuccesState());
      }else if (response!=null){
        var finalResponse = jsonDecode(response.body);
        return emit(ResetPasswordErrorState(error: finalResponse["message"]));
      }else{
        return emit(ResetPasswordErrorState(error: "Something went Wrong"));
      }
    }); 
  }
}
