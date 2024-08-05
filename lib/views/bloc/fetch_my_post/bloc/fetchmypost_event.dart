part of 'fetchmypost_bloc.dart';

@immutable
sealed class FetchmypostEvent {}

final class FetchAllMyPostsEvent extends FetchmypostEvent {}
