import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/bloc/explore_bloc/fetch_explore_bloc.dart';
import 'package:frenzy/views/bloc/search_explore_user_bloc/explore_page_search_users_bloc.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/loading_button.dart';
import 'package:frenzy/views/pages/search/widget/debouncer/debouncer.dart';
import 'package:frenzy/views/pages/search/widget/search_field.dart';
import 'package:frenzy/views/pages/search/widget/shimmer.dart';
import 'package:frenzy/views/pages/search/widget/widget_of_explore.dart';

// ignore: must_be_immutable
class ExplorScreen extends StatefulWidget {
    const ExplorScreen({super.key});

  @override
  State<ExplorScreen> createState() => _ExplorScreenState();
}

class _ExplorScreenState extends State<ExplorScreen> {
  
  final searchController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 700);
  String onchangevalue = '';

 @override
  void initState() {
    super.initState();
    context.read<FetchExploreBloc>().add(OnFetchExplorePostsEvent());
  }

  Future<void> _onRefresh() async {
    context.read<FetchExploreBloc>().add(OnFetchExplorePostsEvent());
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Explore',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 25),)),
        bottom: PreferredSize(
          preferredSize: Size(size.width, 60),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: SearchFormFieldExplore(
              controller: searchController,
              hintText: 'Search',
              keyboard: TextInputType.text,
              onTextChanged: (String value) {
                setState(() {
                  onchangevalue = value;
                });
                if (value.isNotEmpty) {
                  _debouncer.run(() {
                    context
                        .read<ExplorePageSearchUsersBloc>()
                        .add(OnSearchAllUsersEvent(query: value));
                  });
                }
              },
            ),
          ),
        ),
      ),
      body: Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: BlocBuilder<FetchExploreBloc, FetchExploreState>(builder:(context, state) {
        if(state is FetchExplorePostsLoadingState){
          return Center(child: loadingAnimationWidget(),);
        }else if(state is FetchExplorePostsSuccesState){
          if (onchangevalue.isEmpty) {
                return postsGridViewWidget(state, size, context, _onRefresh);
              } else {
                return BlocBuilder<ExplorePageSearchUsersBloc,
                    ExplorePageSearchUsersState>(
                  builder: (context, searchState) {
                    if (searchState is ExplorePageSearchUsersLoadingState) {
                      return explorePostShimmerLoading();
                    } else if (searchState
                        is ExplorePageSearchUserSuccesState) {
                      return searchState.users.isEmpty
                          ? errorStateWidget('No User Found!', const TextStyle(color: grey))
                          : filteredUsersListView(searchState, size,);
                    } else {
                      return errorStateWidget('No User Found!', const TextStyle(color: grey));
                    }
                  },
                );
              }
        }else if (state is FetchExplorePostsErrorState) {
              return fetchExploreErrorReloadWidget(context);
            } else {
              // unexpected states
              return errorStateWidget(
                  'Something went wrong, Try refreshing.',const TextStyle(color: grey));
            }
      },),
      ),
    );
  }
}