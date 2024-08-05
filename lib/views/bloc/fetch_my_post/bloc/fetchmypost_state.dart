part of 'fetchmypost_bloc.dart';

@immutable
sealed class FetchmypostState {}

final class FetchmypostInitial extends FetchmypostState {}

final class FetchMyPostSuccesState extends FetchmypostState {
  final List<MyPostModel> posts;

  FetchMyPostSuccesState({required this.posts});
}

final class FetchMyPostLoadingState extends FetchmypostState {}

final class FetchMyPostErrorState extends FetchmypostState {
  final String error;

  FetchMyPostErrorState({required this.error});
}