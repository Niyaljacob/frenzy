import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:frenzy/model/common_model/saved_post_model.dart';
import 'package:frenzy/repository/post_repo/post_repo.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'fetch_saved_posts_event.dart';
part 'fetch_saved_posts_state.dart';

class FetchSavedPostsBloc extends Bloc<FetchSavedPostsEvent, FetchSavedPostsState> {
  FetchSavedPostsBloc() : super(FetchSavedPostsInitial()) {
    on<FetchSavedPostsEvent>((event, emit) {});
    on<SavedPostsInitialFetchEvent>(savedPostsInitialFetchEvent);
  }
}
FutureOr<void> savedPostsInitialFetchEvent(SavedPostsInitialFetchEvent event,
      Emitter<FetchSavedPostsState> emit) async {
    emit(FetchSavedPostsLoadingState());
    final Response result = await PostRepository.fetchSavedPosts();
    final responseBody = jsonDecode(result.body);
    final List data = responseBody;
    debugPrint('saved post fetch statuscode-${result.statusCode}');

    if (result.statusCode == 200) {
      final List<SavedPostModel> posts =
          data.map((json) => SavedPostModel.fromJson(json)).toList();
      emit(FetchSavedPostsSuccesfulState(posts: posts));
    } else if (result.statusCode == 500) {
      emit(FetchSavedPostsServerErrorState());
    } else {
      emit(FetchSavedPostsErrorState());
    }
  }

