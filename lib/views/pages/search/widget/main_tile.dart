import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/bloc/like_unlike_post_bloc/like_unlike_post_bloc.dart';
import 'package:frenzy/views/pages/home/screen_home.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:readmore/readmore.dart';

class ExplorePageMainTile extends StatelessWidget {
  const ExplorePageMainTile({
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
  final dynamic statesaved;
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
                  height: media.height * 0.06,
                  width: media.height * 0.06,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(profileImage),
                      fit: BoxFit.cover,
                    ),
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
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
                //
              ],
            ),
            
            kheight,
            Padding(
              padding: const EdgeInsets.only(left: 65),
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
                bool isLiked = post.likes.contains(logginedUserId);
                int currentLikeCount = post.likes.length;

                return Padding(
                  padding: const EdgeInsets.only(left: 55),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (isLiked) {
                                context.read<LikeUnlikePostBloc>().add(
                                      UnlikePostButtonClickEvent(postId: post.id),
                                    );
                  
                                post.likes.remove(logginedUserId);
                              } else {
                                context.read<LikeUnlikePostBloc>().add(
                                      LikePostButtonClickEvent(postId: post.id),
                                    );
                  
                                post.likes.add(logginedUserId);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                isLiked ? Icons.favorite : Icons.favorite_border,
                                color: isLiked ? red : primary,
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
