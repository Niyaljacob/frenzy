import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:frenzy/repository/post_repo/post_repo.dart';

part 'addpost_event.dart';
part 'addpost_state.dart';

class AddpostBloc extends Bloc<AddpostEvent, AddpostState> {
  AddpostBloc() : super(AddpostInitial()) {
    on<OnPostButtonClickedEvent>((event, emit) async{
      emit(AddPostLoadingstate());
      final response =await PostRepository.addPost(event.description, event.imagePath);
      if(response!=null && response.statusCode==200){
        emit(AddPostLoadingstate());
        if(kDebugMode){
          print(response.body);
        }
      }else if(response!=null){
        emit(AddPostErrorState(error: 'Something went Wrong'));

      }else{
        emit(AddPostErrorState(error: 'unknown error'));
      }
    });
  }
}
