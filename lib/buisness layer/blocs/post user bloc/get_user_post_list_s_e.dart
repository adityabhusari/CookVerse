import 'package:equatable/equatable.dart';

import '../../../data layer/models/post_model.dart';

enum GetUserPostStatus {initial, success, failure, loading}

abstract class GetUserPostEvents extends Equatable{}

class GetUserPostEvent extends GetUserPostEvents{

  final List<dynamic> myRecipes;

  GetUserPostEvent({required this.myRecipes});

  @override
  // TODO: implement props
  List<Object?> get props => [myRecipes];

}


class GetUserPostState extends Equatable{
  final List<Post> postList;
  final GetUserPostStatus getUserPostStatus;

  GetUserPostState({this.postList = const [], required this.getUserPostStatus});

  GetUserPostState.initial() : this(getUserPostStatus: GetUserPostStatus.initial);

  GetUserPostState.loading() : this(getUserPostStatus: GetUserPostStatus.loading);

  GetUserPostState.success(List<Post> postList) : this(getUserPostStatus: GetUserPostStatus.success, postList: postList);

  GetUserPostState.failure() : this(getUserPostStatus: GetUserPostStatus.failure);

  @override
  // TODO: implement props
  List<Object?> get props => [postList, getUserPostStatus];
}