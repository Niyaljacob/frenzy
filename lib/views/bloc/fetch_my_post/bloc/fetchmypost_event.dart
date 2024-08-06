part of 'fetchmypost_bloc.dart';

@immutable
sealed class FetchmypostEvent {}

final class FetchAllMyPostsEvent extends FetchmypostEvent {}

final class OnMyPostDeleteButtonPressedEvent extends FetchmypostEvent {
  final String postId;

  OnMyPostDeleteButtonPressedEvent({required this.postId});
}

final class OnEditPostButtonClicked extends FetchmypostEvent {
  final dynamic image;
  final String imageUrl;
  final String description;
  final String postId;

  OnEditPostButtonClicked({
    required this.image,
    required this.description,
    required this.postId,
    required this.imageUrl,
  });
}
