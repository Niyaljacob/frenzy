
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/model/common_model/comment_model.dart';
import 'package:frenzy/views/bloc/get_comment_bloc/get_comments_bloc.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/comment_page.dart';
import 'package:frenzy/views/pages/home/widgets/load_more.dart';
import 'package:frenzy/views/pages/home/widgets/main_widget.dart';

Widget buildPostList({
  required BuildContext context,
  required Size media,
  required List<dynamic> posts,
  required ScrollController scrollController,
  required bool isLoadingMore,
  required TextEditingController commentControllers,
  required GlobalKey<FormState> formKey,
  required List<Comment> comments,
}) {
  return ListView.builder(
    controller: scrollController,
    itemCount: posts.length + 1, // Extra item for the loading indicator
    itemBuilder: (context, index) {
      if (index == posts.length) {
        return LoadingIndicator(isLoadingMore: isLoadingMore);
      }
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: HomeWidgetMain(
          onCommentTap: () {
            context.read<GetCommentsBloc>().add(CommentsFetchEvent(
                postId: posts[index].id.toString()));
            commentBottomSheet(context, posts[index], commentControllers,
                formkey: formKey,
                comments: comments,
                id: posts[index].id.toString());
          },
          onSaveTap: () {},
          media: media,
          model: posts[index],
          index: index,
        ),
      );
    },
  );
}