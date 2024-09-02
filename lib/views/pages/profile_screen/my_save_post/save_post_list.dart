
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/bloc/all_followers_posts_bloc/all_followers_posts_bloc.dart';
import 'package:frenzy/views/bloc/fetch_saved_post/fetch_saved_posts_bloc.dart';
import 'package:frenzy/views/bloc/like_unlike_post_bloc/like_unlike_post_bloc.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/showdialog.dart';
import 'package:frenzy/views/pages/home/screen_home.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:readmore/readmore.dart';

class SavedPostListingPageTile extends StatelessWidget {
  const SavedPostListingPageTile({
    super.key,
    required this.media,
    required this.mainImage,
    required this.profileImage,
    required this.userName,
    required this.postTime,
    required this.description,
    required this.likeCount,
    required this.commentCount,
    required this.index,
    required this.removeSaved,
    required this.statesaved,
    required this.likeButtonPressed,
    required this.commentButtonPressed,
  });

  final String profileImage;
  final String mainImage;
  final String userName;
  final String postTime;
  final String description;
  final String likeCount;
  final String commentCount;
  final VoidCallback likeButtonPressed;
  final VoidCallback? commentButtonPressed;
  final Future<void> Function() removeSaved;
  final FetchSavedPostsSuccesfulState statesaved;
  final Size media;
  final int index;

  @override
  Widget build(BuildContext context) {
    final post = statesaved.posts[index];

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: media.height * 0.065,
                  width: media.height * 0.065,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(profileImage),
                      fit: BoxFit.cover,
                    ),
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(postTime),
                  ],
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  onSelected: (String result) {
                    if (result == 'Remove') {
                      showConfirmationDialog(
                        context: context,
                        title: 'Are you sure?',
                        content: 'Remove this post from saved..!',
                        confirmButtonText: 'Confirm',
                        cancelButtonText: 'Cancel',
                        onConfirm: removeSaved,
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Remove',
                      child: Text('Remove'),
                    ),
                  ],
                ),
              ],
            ),
            
            kheight,
            Padding(
              padding: const EdgeInsets.only(left: 64),
              child: SizedBox(
                height: media.width * 0.55,
                  width: media.width * 0.85,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: mainImage,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return LoadingAnimationWidget.fourRotatingDots(
                          color: grey, size: 30);
                    },
                  ),
                ),
              ),
            ),
            kheight,
            Padding(
              padding: const EdgeInsets.only(left: 64),
              child: ReadMoreText(
                description,
                trimMode: TrimMode.Line,
                trimLines: 2,
                colorClickableText: primary,
                trimCollapsedText: 'more.',
                style: const TextStyle(fontWeight: FontWeight.w500),
                trimExpandedText: 'show less',
                moreStyle: const TextStyle(
                    fontSize: 14, color: grey, fontWeight: FontWeight.bold),
                lessStyle: const TextStyle(
                    fontSize: 14, color: grey, fontWeight: FontWeight.bold),
              ),
            ),
            BlocBuilder<LikeUnlikePostBloc, LikeUnlikePostState>(
              builder: (context, state) {
                bool isLiked = post.postId.likes.contains(logginedUserId);
                int currentLikeCount = post.postId.likes.length;

                return Padding(
                  padding: const EdgeInsets.only(left: 54),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (isLiked) {
                                context.read<LikeUnlikePostBloc>().add(
                                      UnlikePostButtonClickEvent(
                                          postId: post.postId.id),
                                    );
                  
                                post.postId.likes.remove(logginedUserId);
                              } else {
                                context.read<LikeUnlikePostBloc>().add(
                                      LikePostButtonClickEvent(
                                          postId: post.postId.id),
                                    );
                  
                                post.postId.likes.add(logginedUserId);
                              }
                  
                              context
                                  .read<AllFollowersPostsBloc>()
                                  .add(AllFollowersPostsInitialFetchEvent());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                isLiked ? Icons.favorite : Icons.favorite_border,
                                color: isLiked ? red : null,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: commentButtonPressed,
                            icon: const Icon(
                              Icons.mode_comment_outlined,
                              color: primary,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          '$currentLikeCount likes',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
