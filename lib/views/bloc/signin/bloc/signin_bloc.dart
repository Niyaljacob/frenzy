import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:frenzy/repository/authentication/authentication_repo.dart';
import 'package:frenzy/utils/functions/sigin_with_google.dart';
import 'package:http/http.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninInitial()) {
    on<OnSigninButtonClickedEvent>((event, emit) async{
      emit(SigninLoadingState());
      final response= await AuthenticationRepository.userLogin(event.email, event.passowrd);
      if(response!=null && response.statusCode==200){
        return emit(SigninSuccesState());
      }else if(response!=null){
        final responseData = jsonDecode(response.body);
        return emit(SigninErrorState(error: responseData['message']));

      }else{
        return emit(SigninErrorState(error: 'Something went Wrong'));
      }
    });

    on<OnGoogleSignInButtonClickedEvent>((event, emit)async{
      emit(GoogleAuthLoadingstate());
      var response =await siginWithGoogle();
      if (response != null &&
          response.user != null &&
          response.user!.email != null){
            var email = response.user!.email;
            print(email);
            Response? finalResponse = await AuthenticationRepository.googleSignin(email!);
             if (finalResponse != null && finalResponse.statusCode == 200){
               return emit(SigninSuccesState());
             } else if (finalResponse != null) {
          final errorMessage = jsonDecode(finalResponse.body);

          emit(SigninErrorState(error: errorMessage["message"]));
        } else {
          return emit(SigninErrorState(error: 'Something went wrong'));
        }
      } else {
        emit(SigninErrorState(error: 'account not found'));
      }
          }
    );
  }
}
