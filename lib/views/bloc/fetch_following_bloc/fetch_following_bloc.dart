
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:frenzy/model/user_suggestions/following_model.dart';
import 'package:frenzy/repository/user_repository/user_repo.dart';
import 'package:http/http.dart';



import 'package:meta/meta.dart';

part 'fetch_following_event.dart';
part 'fetch_following_state.dart';

class FetchFollowingBloc extends Bloc<FetchFollowingEvent, FetchFollowingState> {
  FetchFollowingBloc() : super(FetchFollowingInitial()) {
    on<OnFetchFollowingUsersEvent>((event, emit)async{
      emit(FetchFollowingLoadingState());
      final Response result=await UserRepo.fetchFollowing();
            debugPrint('followers fetch status code-${result.statusCode}');
    if (result.statusCode == 200) {
            final Map<String, dynamic> responseBody = jsonDecode(result.body);
           final FollowingsModel followingsModel =
              FollowingsModel.fromJson(responseBody);
         return emit(FetchFollowingSuccesState(model: followingsModel));
      } else {
      //  print("error");
        return emit(FetchFollowingErrorState());
      }
    });
  }
}
