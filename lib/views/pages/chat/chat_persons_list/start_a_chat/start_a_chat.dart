
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/model/common_model/following_model.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:frenzy/views/bloc/fetch_conv_bloc/fetch_all_conversations_bloc.dart';
import 'package:frenzy/views/bloc/fetch_followers_bloc/fetch_followers_bloc.dart';
import 'package:frenzy/views/bloc/fetch_following_bloc/fetch_following_bloc.dart';
import 'package:frenzy/views/pages/chat/chat_page/chat_screen.dart';
import 'package:frenzy/views/pages/chat/chat_persons_list/start_a_chat/rich_text.dart';
import 'package:frenzy/views/pages/home/screen_home.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/shimmer_widget.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_consumer.dart';

class StartAChat extends StatefulWidget {
  const StartAChat({super.key});

  @override
  State<StartAChat> createState() => _StartAChatState();
}

class _StartAChatState extends State<StartAChat> {
  @override
  void initState() {
    context.read<FetchFollowingBloc>().add(OnFetchFollowingUsersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? whiteColor
            : black,
        surfaceTintColor: Theme.of(context).brightness == Brightness.light
            ? whiteColor
            : black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: const Text(
          'New Chat',
          style:  TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
),
        ),
      ),
      body: MultiBlocConsumer(
        blocs: [
          context.watch<FetchFollowingBloc>(),
          context.watch<ConversationBloc>(),
        ],
        buildWhen: null,
        listener: (context, state) {},
        builder: (context, state) {
          if (state[0] is FetchFollowingSuccesState) {
            final FollowingsModel followings = state[0].model;
            return followings.following.isEmpty
                ? const Center(child: Richtext())
                : ListView.builder(
                    itemCount: followings.totalCount,
                    itemBuilder: (context, index) {
                      final Follower following = followings.following[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: GestureDetector(
                                onTap: () {
                                  context.read<ConversationBloc>().add(
                                          CreateConversationButtonClickEvent(
                                              members: [
                                            logginedUserId,
                                            following.id.toString()
                                          ]));
                                  if (state[1] is ConversationSuccesfulState) {
                                    context
                                        .read<FetchAllConversationsBloc>()
                                        .add(
                                            AllConversationsInitialFetchEvent());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatScreen(
                                                  username: following.userName
                                                      .toString(),
                                                  recieverid:
                                                      following.id.toString(),
                                                  name: following.userName
                                                      .toString(),
                                                  profilepic: following
                                                      .profilePic
                                                      .toString(),
                                                  conversationId:
                                                      state[1].conversationId,
                                                )));
                                  }
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: whiteColor,
                                    radius: 28,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          following.profilePic.toString()),
                                      radius: 26,
                                    ),
                                  ),
                                  title: Text(
                                    following.userName.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  subtitle: Text(
                                    following.name == null
                                        ? 'Guest User'
                                        : following.name.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                )),
                          ),
                        ),
                      );
                    });
          }
          if (state[0] is FetchFollowersLoadingState) {
            return ListView.builder(
              itemBuilder: (context, index) => shimmerTile(),
              itemCount: 5,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
