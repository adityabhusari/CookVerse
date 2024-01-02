

import 'package:equatable/equatable.dart';

import '../../../data layer/models/post_model.dart';

enum GetPostStatus {initial, success, failure, loading}

abstract class GetPostEvents extends Equatable{}

class GetPostEvent extends GetPostEvents{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

abstract class GetPostStates extends Equatable{}

class GetPostsState extends GetPostStates{
  final List<Post> postList;
  final GetPostStatus getPostStatus;

  GetPostsState({this.postList = const [], required this.getPostStatus});

  GetPostsState.initial() : this(getPostStatus: GetPostStatus.initial);

  GetPostsState.loading() : this(getPostStatus: GetPostStatus.loading);

  GetPostsState.success(List<Post> postList) : this(getPostStatus: GetPostStatus.success, postList: postList);

  GetPostsState.failure() : this(getPostStatus: GetPostStatus.failure);

  @override
  // TODO: implement props
  List<Object?> get props => [postList, getPostStatus];
}