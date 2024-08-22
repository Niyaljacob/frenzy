import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/model/common_model/comment_model.dart';
import 'package:frenzy/model/common_model/followers_post_model.dart';
import 'package:frenzy/model/common_model/followers_users_id.dart';
import 'package:frenzy/model/common_model/post_user_model.dart';
import 'package:frenzy/model/common_model/saved_post_model.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/utils/functions/sigin_with_google.dart';
import 'package:frenzy/views/bloc/fetch_saved_post/fetch_saved_posts_bloc.dart';
import 'package:frenzy/views/bloc/like_unlike_post_bloc/like_unlike_post_bloc.dart';
import 'package:frenzy/views/bloc/saved_post/saved_post_bloc.dart';
import 'package:frenzy/views/pages/profile_screen/profilescreen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';
import 'package:readmore/readmore.dart';

// ignore: must_be_immutable
class HomeWidgetMain extends StatelessWidget {
  HomeWidgetMain({
    super.key,
    required this.media,
    required this.model,
    required this.onCommentTap,
    required this.onSaveTap,
    required this.index,
  });
   final Size media;
  final FollwersPostModel model;

  final VoidCallback onCommentTap;
  final VoidCallback onSaveTap;
  final int index;

  List<SavedPostModel> posts = [];
  List<Comment> comments = [];

  @override
  Widget build(BuildContext context) {
    final createdAt = DateTime.parse(model.createdAt.toString());
    final editedTime = DateTime.parse(model.editedTime.toString());

    bool isEdited =
        !areDateTimesEqualIgnoringMilliseconds(createdAt, editedTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: model.userId.profilePic.toString(),
              imageBuilder: (context, imageProvider) => Container(
                height: media.height * 0.065,
                width: media.height * 0.065,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              placeholder: (context, url) => const CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: grey,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(
  width: 10,
),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.userId.name ?? model.userId.userName.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(
                  isEdited
                      ? "${formatDate(editedTime.toString())} (Edited)"
                      : formatDate(createdAt.toString()),
                ),
              ],
            )
          ],
        ),
        
        kheight,
        // Post Image Section
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
                imageUrl: model.image.toString(),
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
        // Post Description Section
        Padding(
          padding: const EdgeInsets.only(left: 64),
          child: ReadMoreText(
            model.description ?? '',
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
        MultiBlocBuilder(
          blocs: [
            context.watch<LikeUnlikePostBloc>(),
            context.watch<FetchSavedPostsBloc>(),
            context.watch<SavedPostBloc>(),
          ],
          builder: (context, state) {
            var state2 = state[1];
            if (state2 is FetchSavedPostsSuccesfulState) {
              posts = state2.posts;
            }

            return Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          final currentUserId = userdetails.id;
                          final isLiked =
                              model.likes.any((user) => user.id == currentUserId);
                          if (!isLiked) {
                            model.likes.add(FollowersUserIdModel.fromJson(User(
                                    id: userdetails.id,
                                    userName: userdetails.userName,
                                    email: userdetails.email,
                                    profilePic: userdetails.profilePic,
                                    phone: userdetails.phone,
                                    online: userdetails.online,
                                    blocked: userdetails.blocked,
                                    verified: userdetails.verified,
                                    createdAt: userdetails.createdAt,
                                    updatedAt: userdetails.updatedAt,
                                    v: 1,
                                    role: userdetails.role,
                                    backGroundImage: userdetails.backGroundImage,
                                    isPrivate: userdetails.isPrivate)
                                .toJson()));
              
                            context.read<LikeUnlikePostBloc>().add(
                                LikePostButtonClickEvent(
                                    postId: model.id.toString()));
                          } else {
                            model.likes
                                .removeWhere((user) => user.id == currentUserId);
                            context.read<LikeUnlikePostBloc>().add(
                                UnlikePostButtonClickEvent(
                                    postId: model.id.toString()));
                          }
                        },
                        icon: Icon(
                          model.likes.any((user) => user.id == userdetails.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                              model.likes.any((user) => user.id == userdetails.id)
                                  ? red
                                  : primary,
                        ),
                      ),
                      Text('${model.likes.length} likes'),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: onCommentTap,
                        icon: const Icon(
                          Icons.mode_comment_outlined,
                        ),
                        iconSize: 28,
                        color: primary,
                      ),
                      Text("${model.commentCount} comments")
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        if (posts
                            .any((element) => element.postId.id == model.id)) {
                          context.read<SavedPostBloc>().add(
                              RemoveSavedPostButtonClickEvent(
                                  postId: model.id.toString()));
                          posts.removeWhere(
                              (element) => element.postId.id == model.id);
                        } else {
                          posts.add(SavedPostModel(
                              userId: model.userId.id.toString(),
                              postId: PostId(
                                  id: model.id.toString(),
                                  userId: UserIdSavedPost.fromJson(
                                      model.userId.toJson()),
                                  image: model.image.toString(),
                                   description: model.description.toString(),
                                  likes: model.likes,
                                  hidden: model.hidden,
                                  blocked: model.blocked,
                                  tags: model.tags,
                                  date: model.date,
                                  createdAt: model.createdAt,
                                  updatedAt: model.updatedAt,
                                  v: model.v,
                                  taggedUsers: model.taggedUsers),
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                              v: model.v));
                          context.read<SavedPostBloc>().add(
                              SavePostButtonClickEvent(
                                  postId: model.id.toString()));
                        }
                      },
                      icon: Icon(
                        posts.any((element) => element.postId.id == model.id)
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: primary,
                        size: 25,
                      ))
                ],
              ),
            );
          },
        )
      ],
    );
  }

  bool areDateTimesEqualIgnoringMilliseconds(
      DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day &&
        dateTime1.hour == dateTime2.hour &&
        dateTime1.minute == dateTime2.minute &&
        dateTime1.second == dateTime2.second;
  }
}