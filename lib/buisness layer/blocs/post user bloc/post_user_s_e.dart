import 'package:equatable/equatable.dart';
import 'package:last/data%20layer/models/post_model.dart';
import 'package:last/data%20layer/models/user_model.dart';

enum GetUserForPostStatus {loading, success, failure}

abstract class PostUserEvents extends Equatable{}



class GetUserAndPostModelEvent extends PostUserEvents{
  final String uid;
  final String pid;

  GetUserAndPostModelEvent({required this.uid, required this.pid});

  @override
  // TODO: implement props
  List<Object?> get props => [uid, pid];

}

abstract class PostUserStates extends Equatable{}

class PostUserStateInitial extends PostUserStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetUserAndPostState extends PostUserStates{

  final UserModel userModel;
  final Post postModel;
  final GetUserForPostStatus getUserForPostStatus;

  GetUserAndPostState({required this.userModel,required this.postModel ,required this.getUserForPostStatus});

  GetUserAndPostState.success(UserModel userModel, Post post) : this(userModel: userModel, postModel: post,getUserForPostStatus: GetUserForPostStatus.success);

  GetUserAndPostState.loading() : this(userModel: UserModel.empty, postModel: Post.empty, getUserForPostStatus: GetUserForPostStatus.loading);

  GetUserAndPostState.failure() : this(getUserForPostStatus: GetUserForPostStatus.failure, postModel: Post.empty,userModel: UserModel.empty);

  @override
  // TODO: implement props
  List<Object?> get props => [userModel, getUserForPostStatus, postModel];

}
