import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/model/common_model/explore_users_user_model.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/bloc/fetch_following_bloc/fetch_following_bloc.dart';
import 'package:frenzy/views/bloc/follow_unfollow_bloc/follow_unfollow_bloc.dart';
import 'package:frenzy/views/bloc/suggestion_bloc/fetch_user_suggestions_bloc.dart';
import 'package:frenzy/views/pages/common_widgets/list_tile.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/shimmer_widget.dart';
import 'package:frenzy/views/pages/search/widget/explore_user_profile.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

class SuggestionPage extends StatefulWidget {
  const SuggestionPage({super.key});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {

  @override
  void initState() {
    context.read<FetchUserSuggestionsBloc>().add(OnfetchUserSuggestionEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text('Suggestions'),
      ),
      body: BlocListener<FollowUnfollowBloc, FollowUnfollowState>(
        listener: (context, followState) {
          if (followState is FollowUserSuccesfulState ||
              followState is UnFollowUserSuccesfulState) {
            context
                .read<FetchUserSuggestionsBloc>()
                .add(OnfetchUserSuggestionEvent());
            context
                .read<FetchFollowingBloc>()
                .add(OnFetchFollowingUsersEvent());
          }
        },
        child: BlocConsumer<FetchUserSuggestionsBloc, FetchUserSuggestionsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FetchUserSuggestionsSuccessState) {
              if (state.suggessionModel.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No suggestions available at the moment.',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: state.suggessionModel.data!.length,
                  itemBuilder: (context, index) {
                    var suggestion = state.suggessionModel.data![index];
                    return BlocBuilder<FollowUnfollowBloc, FollowUnfollowState>(
                      builder: (context, followState) {
                        if (followState is FollowUserLoadingState) {
                          return Center(
                            child: LoadingAnimationWidget.fourRotatingDots(
                              color: grey,
                              size: 30,
                            ),
                          );
                        }
                        return CustomListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScreenExploreUserProfile(
                                  userId: suggestion.id.toString(),
                                  user: UserIdSearchModel(
                                    bio: suggestion.bio ?? '',
                                    id: suggestion.id.toString(),
                                    userName: suggestion.userName.toString(),
                                    email: suggestion.email.toString(),
                                    profilePic: suggestion.profilePic.toString(),
                                    online: suggestion.online ?? true,
                                    blocked: suggestion.blocked ?? false,
                                    verified: suggestion.verified ?? false,
                                    role: suggestion.role.toString(),
                                    isPrivate: suggestion.isPrivate ?? false,
                                    backGroundImage: suggestion.backGroundImage.toString(),
                                    createdAt: suggestion.createdAt ?? DateTime(2000),
                                    updatedAt: suggestion.updatedAt ?? DateTime(2000),
                                    v: suggestion.v ?? 0,
                                  ),
                                ),
                              ),
                            );
                          },
                          profileImageUrl: suggestion.profilePic.toString(),
                          buttonText: 'Follow',
                          onUnfollow: () {
                            context.read<FollowUnfollowBloc>().add(
                                  OnFollowButtonClickedEvent(
                                    followeesId: suggestion.id.toString(),
                                  ),
                                );
                          },
                          titleText: suggestion.userName.toString(),
                          imageSize: size.height * 0.05,
                          backgroundColor: whiteColor,
                          borderRadius: BorderRadius.circular(100),
                        );
                      },
                    );
                  },
                );
              }
            } else if (state is FetchUserSuggestionsLoadingState) {
              return ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: shimmerTile());
                },
              );
            } else if (state is FetchUserSuggestionsErroState) {
              return const Center(
                child: Text(
                  'Failed to load suggestions. Please try again later.',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'No suggestions available at the moment.',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
