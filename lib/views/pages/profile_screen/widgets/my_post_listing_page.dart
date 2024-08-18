import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/model/my_post_model/my_post_model.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/bloc/fetch_my_post/bloc/fetchmypost_bloc.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/showdialog.dart';
import 'package:frenzy/views/pages/profile_screen/my_post/update_user_post/update_user_post.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:readmore/readmore.dart';

class MyPostListingPageTile extends StatelessWidget {
  final List<MyPostModel> post;
  const MyPostListingPageTile(
      {super.key,
      required this.media,
      required this.mainImage,
      required this.profileImage,
      required this.post,
      required this.userName,
      required this.postTime,
      required this.description,
      required this.likeCount,
      required this.commentCount,
      required this.likeButtonPressed,
      required this.commentButtonPressed,
      required this.index});
  final String profileImage;
  final String mainImage;
  //  final void Function() onTapSettings;
  final String userName;
  final String postTime;
  final String description;
  final String likeCount;
  final String commentCount;
  final VoidCallback likeButtonPressed;
  final VoidCallback commentButtonPressed;

  final Size media;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
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
                          image: NetworkImage(profileImage), fit: BoxFit.cover),
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(100)),
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
                PopupMenuButton<String>(
                  onSelected: (String result) {
                    if (result == 'Edit') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScreenUpdateUserPost(
                              model: post[index],
                            ),
                          ));
                    } else if (result == 'Delete') {
                      showConfirmationDialog(
                          context: context,
                          title: 'Are you sure?',
                          content:
                              'this action will remove this post permenently ',
                          confirmButtonText: 'confirm',
                          cancelButtonText: 'cancel',
                          onConfirm: () async {
                            context.read<FetchmypostBloc>().add(
                                OnMyPostDeleteButtonPressedEvent(
                                    postId: post[index].id.toString()));
                            context
                                .read<FetchmypostBloc>()
                                .add(FetchAllMyPostsEvent());
                          });
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Delete',
                      child: Text('Delete'),
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
                        color: grey,
                        size: 30,
                      );
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
                colorClickableText: Colors.blueAccent,
                trimCollapsedText: 'more.',
                style: const TextStyle(fontWeight: FontWeight.w500),
                trimExpandedText: 'show less',
                moreStyle: const TextStyle(
                    fontSize: 14, color: grey, fontWeight: FontWeight.bold),
                lessStyle: const TextStyle(
                    fontSize: 14, color: grey, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 53),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border,
                        ),
                        iconSize: 30,
                        color: primary,
                      ),
                      IconButton(
                        onPressed: commentButtonPressed,
                        icon: const Icon(
                          Icons.mode_comment_outlined,
                        ),
                        iconSize: 28,
                        color: primary,
                      ),
                      // IconButton(onPressed: () {}, icon: Image.asset(savePostIcon))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text('$likeCount likes'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
