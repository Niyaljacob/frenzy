import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/model/my_post_model/my_post_model.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/bloc/fetch_saved_post/fetch_saved_posts_bloc.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/loading_button.dart';
import 'package:frenzy/views/pages/profile_screen/my_post/screen_my_post.dart';
import 'package:frenzy/views/pages/profile_screen/my_save_post/saved_post_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

class MyPostsGrid extends StatelessWidget {
  final List<MyPostModel> post;
   const MyPostsGrid({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    if (post.isEmpty) {
      return const Center(
        child: Text(
          'No posts available',
          style: TextStyle(color: grey),
        ),
      );
    }
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:3,
         crossAxisSpacing: 10,
         mainAxisSpacing: 10
         ),
         itemCount: post.length,
         itemBuilder: (context, index) {
           return GestureDetector(
            onTap: (){
               Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScreenMyPost(index: index, post: post),
              ),
            );
            },
            child: CachedNetworkImage(
            imageUrl: post[index].image.toString(),
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.grey,
                ),
              );
            },
          ),
           );
         },
    );
  }
}

class SavedPostsGrid extends StatelessWidget {
  const SavedPostsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchSavedPostsBloc, FetchSavedPostsState>(
      builder: (context, state) {
        if(state is FetchSavedPostsSuccesfulState){
          if(state.posts.isNotEmpty){
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                ), 
              itemCount:state.posts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return SavedPostScreen(model: state.posts);
                      }));
                  },
                    child: CachedNetworkImage( 
                    placeholder: (context, url) {
                      return LoadingAnimationWidget.fourRotatingDots(
                          color: grey, size: 30);
                    },
                    imageUrl: state.posts[index].postId.image,
                    fit: BoxFit.cover,
                  ),
                );
              },
              );
          }else {
            return errorStateWidget('no items found', const TextStyle(color: grey));
          }
        }else if (state is FetchSavedPostsLoadingState) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
                color: primary, size: 30),
          );
        } else {
          return errorStateWidget('something went wrong', const TextStyle(color: grey));
        }
      },
    );
  }
}