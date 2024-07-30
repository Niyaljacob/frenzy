import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:frenzy/model/user_model.dart';
import 'package:frenzy/repository/authentication/authentication_repo.dart';
import 'package:http/http.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<OnSignupButtonClickedEvent>((event, emit) async {
      emit(SignUpLoadingState());

      UserModel finalDatas = UserModel(
        userName: event.userName,
        password: event.password,
        phoneNumber: event.phoneNumber,
        emailId: event.email,
      );

      Response? response =
          await AuthenticationRepository().sentingOtp(finalDatas);
      if (response != null && response.statusCode == 200) {
        return emit(SignUpSuccesState());
      } else if (response != null) {
        final responseData = jsonDecode(response.body);

        return emit(SignUpErrorState(error: responseData["message"]));
      } else {
        return emit(SignUpErrorState(error: "something went wrong"));
      }
    });
  }
}
