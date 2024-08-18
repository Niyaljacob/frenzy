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

final class OnDeleteButtonClickedLoadingState extends FetchmypostState {}

final class OnDeleteButtonClickedSuccesState extends FetchmypostState {}

final class OnDeleteButtonClickedErrrorState extends FetchmypostState {
  final String error;

  OnDeleteButtonClickedErrrorState({required this.error});
}

final class EditUserPostLoadingState extends FetchmypostState {}

final class EditUserPostSuccesState extends FetchmypostState {}

final class EditUserPosterrorState extends FetchmypostState {
  final String error;

  EditUserPosterrorState({required this.error});
}