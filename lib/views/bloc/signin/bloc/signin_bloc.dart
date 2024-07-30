import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:frenzy/repository/authentication/authentication_repo.dart';
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
  }
}
