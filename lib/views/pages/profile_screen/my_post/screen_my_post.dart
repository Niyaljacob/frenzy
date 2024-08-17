
import 'package:frenzy/utils/functions/sigin_with_google.dart';
import 'package:frenzy/views/bloc/get_comment_bloc/get_comments_bloc.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/comment_bottom_sheet.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/model/my_post_model/my_post_model.dart';
import 'package:frenzy/model/common_model/comment_model.dart';
import 'package:frenzy/views/bloc/fetch_my_post/bloc/fetchmypost_bloc.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/my_post_listing_page.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/shimmer_widget.dart';
import 'package:shimmer/shimmer.dart';

class ScreenMyPost extends StatefulWidget {
   final int index;
  const ScreenMyPost({super.key, required this.index,required List<MyPostModel> post});

  @override
  State<ScreenMyPost> createState() => _ScreenMyPostState();
}

class _ScreenMyPostState extends State<ScreenMyPost> {
  TextEditingController commentController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<Comment> _comments = [];

  @override
  void initState() {
    context.read<FetchmypostBloc>().add(FetchAllMyPostsEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Post'),
        automaticallyImplyLeading: true,),
        body: BlocBuilder<FetchmypostBloc, FetchmypostState>(
          builder: (context, state){
            if(state is FetchMyPostLoadingState){
              return ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: shimmerWidget1(size));
                },
                );
            }else if (state is FetchMyPostSuccesState){
              if(state.posts.isEmpty){
                return const Center(child: Text('No posts Available.'),);
              }
              return ListView.builder(
                controller:
                  ScrollController(initialScrollOffset: widget.index * 700),
                itemBuilder:(context, index) {
                  final postItem = state.posts[index];
                  return MyPostListingPageTile(
                  media: size,
                  mainImage: postItem.image.toString(),
                  profileImage: postItem.userId?.profilePic ?? '',
                  post: state.posts,

                  userName: postItem.userId?.userName.toString() ?? '',
                  postTime: postItem.createdAt == postItem.editedTime
                      ? formatDate(postItem.createdAt.toString())
                      : ("${formatDate(postItem.editedTime.toString())} (Edited)"),
                  description: postItem.description.toString(),
                  likeCount: postItem.likes!.length.toString(),
                  commentCount: '2', // need to add
                  likeButtonPressed: () {},
                  commentButtonPressed: () {
                    // context.read<GetCommentsBloc>().add(
                    //     CommentsFetchEvent(postId: postItem.id.toString()));
                    // commentBottomSheet(context, postItem, commentController,
                    //     formkey: _formkey,
                    //     // userName: profileuserName,
                    //     // profiePic: logginedUserProfileImage,
                    //     comments: _comments,
                    //     id: postItem.id.toString());
                  },
                  index: index,
                );
                },
                itemCount: state.posts.length,
                );
            }else if (state is FetchMyPostErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: Text('No posts available.'));
          },
          ),
    );
  }
}