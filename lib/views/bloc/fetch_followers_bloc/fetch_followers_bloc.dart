import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:frenzy/model/common_model/followers_model.dart';
import 'package:frenzy/repository/user_repository/user_repo.dart';
import 'package:http/http.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'fetch_followers_event.dart';
part 'fetch_followers_state.dart';

class FetchFollowersBloc extends Bloc<FetchFollowersEvent, FetchFollowersState> {
  FetchFollowersBloc() : super(FetchFollowersInitial()) {
    on<OnfetchAllFollowersEvent>((event, emit) async{
      emit(FetchFollowersLoadingState());
      final Response result = await UserRepo.fetchFollowers();
      final responseBody = jsonDecode(result.body);
      if (result.statusCode == 200) {
        final FollowersModel followersModel =
            FollowersModel.fromJson(responseBody);
        return emit(FetchFollowersSuccesState(followersModel: followersModel));
      } else {
        return emit(FetchFollowersErrorState());
      }

    });
  }
}
