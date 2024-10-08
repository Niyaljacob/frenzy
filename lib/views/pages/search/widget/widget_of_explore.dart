// Function to build the grid view of posts

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/bloc/explore_bloc/fetch_explore_bloc.dart';
import 'package:frenzy/views/bloc/search_explore_user_bloc/explore_page_search_users_bloc.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/loading_button.dart';
import 'package:frenzy/views/pages/common_widgets/list_tile.dart';
import 'package:frenzy/views/pages/search/widget/explore_user_profile.dart';
import 'package:frenzy/views/pages/search/widget/screen_explore_scroll.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget postsGridViewWidget(FetchExplorePostsSuccesState state, Size media,
    BuildContext context, Future<void> Function() onrefresh) {
  if (state.posts.isEmpty) {
    return errorStateWidget('No posts available', const TextStyle(color: grey));
  }

  return RefreshIndicator(
    onRefresh: onrefresh,
    child: MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: state.posts.length,
      itemBuilder: (context, index) {
        final post = state.posts[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenExplore(),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                post.image,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    //   child:
                    child: LoadingAnimationWidget.threeRotatingDots(
                        color: primary, size: 30),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: grey,
                  );
                },
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget fetchExploreErrorReloadWidget(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Something went wrong. Try refreshing.',
          style: TextStyle(color: red, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () =>
              context.read<FetchExploreBloc>().add(OnFetchExplorePostsEvent()),
          child: const Text('Retry'),
        ),
      ],
    ),
  );
}

// Function to build the list view of users
Widget filteredUsersListView(
  ExplorePageSearchUserSuccesState state,
  Size media,
) {
  return ListView.builder(
    itemBuilder: (context, index) => CustomListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScreenExploreUserProfile(
                  userId: state.users[index].id.toString(),
                  user: state.users[index]),
            ));
      },
      profileImageUrl: state.users[index].profilePic.toString(),
      buttonText: '',
      titleText: state.users[index].userName.toString(),
      imageSize: media.height * 0.05,
      backgroundColor: whiteColor,
      borderRadius: BorderRadius.circular(100),
    ),
    itemCount: state.users.length,
  );
}
