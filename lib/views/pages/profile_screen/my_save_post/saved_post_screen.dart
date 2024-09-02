import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/model/common_model/comment_model.dart';
import 'package:frenzy/model/common_model/saved_post_model.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/utils/functions/sigin_with_google.dart';
import 'package:frenzy/views/bloc/fetch_saved_post/fetch_saved_posts_bloc.dart';
import 'package:frenzy/views/bloc/get_comment_bloc/get_comments_bloc.dart';
import 'package:frenzy/views/bloc/saved_post/saved_post_bloc.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/comment_page.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/loading_button.dart';
import 'package:frenzy/views/pages/profile_screen/my_save_post/save_post_list.dart';

class SavedPostScreen extends StatelessWidget {
   SavedPostScreen({super.key, required this.model});
   final List<SavedPostModel> model;
  final TextEditingController commentController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<Comment> _comments = [];
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
       appBar: AppBar(
        centerTitle: true,
        title: const Text('Saved Posts'),
        backgroundColor: primary,
      ),
      body: BlocBuilder<FetchSavedPostsBloc, FetchSavedPostsState>(
        builder: (context, state) {
          if (state is FetchSavedPostsSuccesfulState) {
            if (state.posts.isNotEmpty) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return SavedPostListingPageTile(
                    statesaved: state,
                    media: size,
                    mainImage: state.posts[index].postId.image,
                    profileImage: state.posts[index].postId.userId.profilePic,
                    userName: state.posts[index].postId.userId.userName,
                    postTime: state.posts[index].createdAt ==
                            state.posts[index].editedTime
                        ? formatDate(state.posts[index].createdAt.toString())
                        : ("${formatDate(state.posts[index].editedTime.toString())} (Edited)"),
                    description: state.posts[index].postId.description,
                    likeCount:
                        state.posts[index].postId.likes.length.toString(),
                    commentCount: '',
                    likeButtonPressed: () {},
                    removeSaved: () async {
                      context.read<SavedPostBloc>().add(
                          RemoveSavedPostButtonClickEvent(
                              postId: state.posts[index].postId.id));
                      context
                          .read<FetchSavedPostsBloc>()
                          .add(SavedPostsInitialFetchEvent());
                    },
                    commentButtonPressed: () {
                      context.read<GetCommentsBloc>().add(CommentsFetchEvent(
                          postId: state.posts[index].postId.id.toString()));
                      commentBottomSheet(
                          context, state.posts[index].postId, commentController,
                          formkey: _formkey,
                          comments: _comments,
                          id: state.posts[index].postId.id.toString());
                    },
                    index: index,
                  );
                },
                itemCount: state.posts.length,
              );
            } else {
              return errorStateWidget('no items found', const TextStyle(color: grey));
            }
          } else if (state is FetchSavedPostsLoadingState) {
            return Container();
          } else {
            return errorStateWidget('something went wrong', const TextStyle(color: grey));
          }
        },
      ),
    );
  }
}