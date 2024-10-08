import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:frenzy/model/common_model/explore_users_user_model.dart';
import 'package:frenzy/repository/user_repository/user_repo.dart';
import 'package:http/http.dart';

part 'explore_page_search_users_event.dart';
part 'explore_page_search_users_state.dart';

class ExplorePageSearchUsersBloc extends Bloc<ExplorePageSearchUsersEvent, ExplorePageSearchUsersState> {
  ExplorePageSearchUsersBloc() : super(ExplorePageSearchUsersInitial()) {
    on<OnSearchAllUsersEvent>((event, emit) async {
      emit(ExplorePageSearchUsersLoadingState());
      final Response response =
          await UserRepo.searchAllUsers(query: event.query);
      if (response.statusCode == 200) {
        debugPrint('searchallusers statuscode-${response.statusCode}');
        List<dynamic> jsonResponse = jsonDecode(response.body);
        final List<UserIdSearchModel> users =
            jsonResponse.map((user) => UserIdSearchModel.fromJson(user)).toList();
        emit(ExplorePageSearchUserSuccesState(users: users));
      } else {
        emit(ExplorePageSearchUsersErrorState());
      }
    });
  }
}

