import 'dart:async';
import 'dart:convert';


import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:frenzy/model/common_model/save_post_model.dart';
import 'package:frenzy/repository/post_repo/post_repo.dart';
import 'package:http/http.dart';

part 'saved_post_event.dart';
part 'saved_post_state.dart';

class SavedPostBloc extends Bloc<SavedPostEvent, SavedPostState> {
  SavedPostBloc() : super(SavedPostInitial()) {
    on<SavedPostEvent>((event, emit) {});
    on<SavePostButtonClickEvent>(savePostButtonClickEvent);
    on<RemoveSavedPostButtonClickEvent>(removeSavedPostButtonClickEvent);
  }

  FutureOr<void> savePostButtonClickEvent(
      SavePostButtonClickEvent event, Emitter<SavedPostState> emit) async {
   
    emit(SavePostLoadingState());
    final Response result = await PostRepository.savePost(postId: event.postId);
    final responseBody = jsonDecode(result.body);

    debugPrint('save post statuscode-${result.statusCode}');

    if (result.statusCode == 200) {
      final SavePostModel post = SavePostModel.fromJson(responseBody);
      emit(SavePostSuccesfulState(post: post));
    } else if (result.statusCode == 500) {
      emit(SavePostServerErrorState());
    } else {
      emit(SavePostErrorState());
    }
  }

  FutureOr<void> removeSavedPostButtonClickEvent(
      RemoveSavedPostButtonClickEvent event,
      Emitter<SavedPostState> emit) async {
    emit(RemoveSavedPostLoadingState());
    final Response result =
        await PostRepository.removeSavedPost(postId: event.postId);
    debugPrint('delete saved post statuscode-${result.statusCode}');
    if (result.statusCode == 200) {
      emit(RemoveSavedPostSuccesfulState());
    } else if (result.statusCode == 500) {
      emit(RemoveSavedPostServerErrorState());
    } else {
      emit(RemoveSavedPostErrorState());
    }
  }
}
