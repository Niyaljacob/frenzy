// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/model/common_model/comment_model.dart';
import 'package:frenzy/model/common_model/post_model.dart';
import 'package:frenzy/utils/functions/sigin_with_google.dart';
import 'package:frenzy/views/bloc/get_comment_bloc/get_comments_bloc.dart';
import 'package:frenzy/views/bloc/profile_post_bloc/profile_bloc.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/comment_page.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/shimmer_widget.dart';
import 'package:frenzy/views/pages/search/widget/main_tile.dart';
import 'package:shimmer/shimmer.dart';

class ScreenOtherUserPosts extends StatelessWidget {
  final List<Post> posts;
  ScreenOtherUserPosts({super.key, required this.posts});
  TextEditingController commentController = TextEditingController();
   final _formkey = GlobalKey<FormState>();
  final List<Comment> _commentss = [];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Posts',
          style: TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
            if(state is ProfilePostFetchSuccesfulState){
             return ListView.builder(
            itemBuilder: (context, index) {
              return ExplorePageMainTile(
                  media: media,
                  mainImage: posts[index].image,
                  profileImage: posts[index].userId.profilePic,
                  userName: posts[index].userId.userName,
                  postTime: formatDate(posts[index].createdAt.toString()),
                  description: posts[index].description,
                  likeCount: posts[index].likes.length.toString(),
                  commentCount: '',
                  index: index,
                  removeSaved: () async {},
                  statesaved: state,
                  likeButtonPressed: () {},
                  commentButtonPressed: ()async {
                    context.read<GetCommentsBloc>().add(
                        CommentsFetchEvent(postId: posts[index].id.toString()));
                    commentBottomSheet(context, posts[index], commentController,
                        formkey: _formkey,
                        comments: _commentss,
                        id: posts[index].id.toString());
                    context.read<GetCommentsBloc>().add(
                        CommentsFetchEvent(postId: posts[index].id.toString()));
                  });
            },
            itemCount: posts.length,
          );
            }else{
                   return ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: shimmerWidget1(media));
              },
            );
            }
          
        },
      ),
    );
  }
}
