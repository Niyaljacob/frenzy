import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:frenzy/model/common_model/post_model.dart';
import 'package:frenzy/repository/user_repository/user_repo.dart';
import 'package:frenzy/utils/functions/sigin_with_google.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<ProfileInitialPostFetchEvent>(profileInitialPostFetchEvent);
  }

  FutureOr<void> profileInitialPostFetchEvent(
      ProfileInitialPostFetchEvent event, Emitter<ProfileState> emit) async {
    emit(ProfilePostFetchLoadingState());
    debugPrint('event user id is -${event.userId}');
    final Response result =
        await UserRepo.fetchUserPostsOther(userId: event.userId);
    final responseBody = jsonDecode(result.body);
    final List<Post> posts = parsePosts(result.body);
    debugPrint('user posts:-$responseBody');

    if (result.statusCode == 200) {
      // log(responseBody.toString());
      emit(ProfilePostFetchSuccesfulState(posts: posts));
    } else if (responseBody['status'] == 404) {
      emit(ProfilePostFetchUserNotFoundState());
    } else if (responseBody['status'] == 500) {
      emit(ProfilePostFetchServerErrorState());
    } else {
      emit(ProfilePostFetchErrorState());
    }
  }
}
