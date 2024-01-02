import 'package:equatable/equatable.dart';

import '../../../data layer/models/post_model.dart';

enum GetUserPostBookmarkStatus {initial, success, failure, loading}

abstract class GetUserPostBookMarkEvents extends Equatable{}

class GetUserBookMarkEvent extends GetUserPostBookMarkEvents{

  final List<dynamic> myBookmarks;

  GetUserBookMarkEvent({required this.myBookmarks});

  @override
  // TODO: implement props
  List<Object?> get props => [myBookmarks];

}

class GetUserPostBookmarkState extends Equatable{
  final List<Post> postList;
  final GetUserPostBookmarkStatus getUserPostBookmarkStatus;

  GetUserPostBookmarkState({this.postList = const [], required this.getUserPostBookmarkStatus});

  GetUserPostBookmarkState.initial() : this(getUserPostBookmarkStatus: GetUserPostBookmarkStatus.initial);

  GetUserPostBookmarkState.loading() : this(getUserPostBookmarkStatus: GetUserPostBookmarkStatus.loading);

  GetUserPostBookmarkState.success(List<Post> postList) : this(getUserPostBookmarkStatus: GetUserPostBookmarkStatus.success, postList: postList);

  GetUserPostBookmarkState.failure() : this(getUserPostBookmarkStatus: GetUserPostBookmarkStatus.failure);

  @override
  // TODO: implement props
  List<Object?> get props => [postList, getUserPostBookmarkStatus];
}