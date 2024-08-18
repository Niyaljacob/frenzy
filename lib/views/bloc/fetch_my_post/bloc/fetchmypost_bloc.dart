import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:frenzy/model/my_post_model/my_post_model.dart';
import 'package:frenzy/repository/post_repo/post_repo.dart';
import 'package:frenzy/repository/user_repository/user_repo.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'fetchmypost_event.dart';
part 'fetchmypost_state.dart';

class FetchmypostBloc extends Bloc<FetchmypostEvent, FetchmypostState> {
  FetchmypostBloc() : super(FetchmypostInitial()) {
    on<FetchAllMyPostsEvent>((event, emit)async {
     emit(FetchMyPostLoadingState());
     final responce = await UserRepo.fetchUserPosts();
     if(responce != null && responce.statusCode==200){
      final responseBody = responce.body;
      final List<MyPostModel>posts = parsePostsFromJson(responseBody);
      return emit(FetchMyPostSuccesState(posts: posts));
      
     }else if (responce!=null){
      final responseBody=jsonDecode(responce.body);
      return emit(FetchMyPostErrorState(error: responseBody["message"]));

     }else{
      return emit(FetchMyPostErrorState(error: "something went wrong"));
     
     }
    });

    on<OnMyPostDeleteButtonPressedEvent>(
      (event, emit)async{
        emit(OnDeleteButtonClickedLoadingState());
        var response=await PostRepository.deletePost(event.postId);
        if (response != null && response.statusCode == 200) {
          add(FetchAllMyPostsEvent());
          return emit(OnDeleteButtonClickedSuccesState());
        }else if(response!=null){
          final responseBody=jsonDecode(response.body);
          return emit(OnDeleteButtonClickedErrrorState(error: responseBody['message']));
        }else{
          return emit(OnDeleteButtonClickedErrrorState(error: 'Something went wrong'));
        }
      }
    );
    on<OnEditPostButtonClicked>(
      (event, emit) async {
        emit(EditUserPostLoadingState());
        final response = await PostRepository.editPost(
            description: event.description,
            image: event.image,
            postId: event.postId,
            imageUrl: event.imageUrl);
        if (response != null && response.statusCode == 200) {
          add(FetchAllMyPostsEvent());
          return emit(EditUserPostSuccesState());
        } else if (response != null && response.statusCode == 500) {
          return emit(EditUserPosterrorState(error: 'Server not responding'));
        } else if (response != null) {
          final responseBody = jsonDecode(response.body);
          return emit(EditUserPosterrorState(error: responseBody['message']));
        } else {
          return emit(EditUserPosterrorState(error: 'Something went wrong'));
        }
      },
    );
  }

  List<MyPostModel> parsePostsFromJson(String jsonString) {
    final List parsedData = jsonDecode(jsonString) as List;
    final List<MyPostModel> posts = [];

    for (var item in parsedData) {
      posts.add(MyPostModel.fromJson(item));
    }

    return posts;
  }
}
