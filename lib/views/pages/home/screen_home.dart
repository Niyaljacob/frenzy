import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/model/common_model/comment_model.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/utils/functions/set_user_loggedin.dart';
import 'package:frenzy/views/bloc/all_followers_posts_bloc/all_followers_posts_bloc.dart';
import 'package:frenzy/views/pages/home/suggestion/suggestion.dart';
import 'package:frenzy/views/pages/home/widgets/post_listing.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/shimmer_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

String logginedUserToken = '';
String logginedUserId = '';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  List<dynamic> _posts = [];
  TextEditingController commentControllers = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<Comment> _comments = [];

  @override
  void initState() {
    context
        .read<AllFollowersPostsBloc>()
        .add(AllFollowersPostsInitialFetchEvent());
    getToken();

    _scrollController.addListener(_onScroll);
    super.initState();
  }

  getToken() async {
    logginedUserToken = (await getUsertoken())!;
    logginedUserId = (await getUserId())!;
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });
      context.read<AllFollowersPostsBloc>().add(LoadMoreEvent());
    }
  }

  Future<void> _onRefresh() async {
    context
        .read<AllFollowersPostsBloc>()
        .add(AllFollowersPostsInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: SizedBox(
              height: size.height * 0.048,
              child: Image.asset(Theme.of(context).brightness == Brightness.light
                  ? singupdark
                  : singuplight)),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.person_search_rounded,
                size: 35,
                color: primary,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const SuggestionPage();
                }));
              },
            ),
          ]),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: BlocBuilder<AllFollowersPostsBloc, AllFollowersPostsState>(
          builder: (context, state) {
            if (state is AllFollowersPostsSuccesfulState) {
              _posts = _filterDuplicates(_posts, state.post);
              _isLoadingMore = false;
            } else if (state is FetchMoreSuccesState) {
              _posts = _filterDuplicates(_posts, state.post);
              _isLoadingMore = false;
            }

            if (_posts.isNotEmpty) {
              return buildPostList(
                context: context,
                media: size,
                posts: _posts,
                scrollController: _scrollController,
                isLoadingMore: _isLoadingMore,
                commentControllers: commentControllers,
                formKey: _formkey,
                comments: _comments,
              );
            } else if (state is AllFollowersPostsLoadingState) {
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: shimmerWidget1(size),
                ),
              );
            } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/Animation - 1724321708925.json', // Replace with your Lottie animation path
                    width: 220,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Start by visiting the suggestion page and following people to see their posts.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: _onRefresh,
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            );
          }
          },
        ),
      ),
    );
  }

  List<dynamic> _filterDuplicates(List<dynamic> oldPosts, List<dynamic> newPosts) {
    final oldIds = oldPosts.map((post) => post.id).toSet();
    final filteredPosts = newPosts.where((newPost) => !oldIds.contains(newPost.id)).toList();
    return [...oldPosts, ...filteredPosts];
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
}
