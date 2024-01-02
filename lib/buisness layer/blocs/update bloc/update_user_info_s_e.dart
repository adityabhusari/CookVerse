import 'package:equatable/equatable.dart';

//EVENTS
abstract class UpdateInfoEvents extends Equatable{}

class UpdateProfilePicEvent extends UpdateInfoEvents{
  final String file;
  final String uid;

  UpdateProfilePicEvent({required this.uid, required this.file});

  @override
  // TODO: implement props
  List<Object?> get props => [file, uid];

}

class UpdateNameEvent extends UpdateInfoEvents{

  final String name;
  final String uid;

  UpdateNameEvent({required this.name, required this.uid});

  @override
  // TODO: implement props
  List<Object?> get props => [name, uid];

}

class AddPostToUserEvent extends UpdateInfoEvents{
  final String postId;
  final String userId;

  AddPostToUserEvent({required this.postId, required this.userId});

  @override
  // TODO: implement props
  List<Object?> get props => [postId, userId];

}

//STATES
abstract class UpdateInfoStates extends Equatable{}

class UserInfoInitialState extends UpdateInfoStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateProfilePicLoading extends UpdateInfoStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateProfilePicFailure extends UpdateInfoStates{
  final String errMsg;

   UpdateProfilePicFailure(this.errMsg);

  @override
  // TODO: implement props
  List<Object?> get props => [errMsg];
}

class UpdateProfilePicSuccess extends UpdateInfoStates{
  final String userPic;

   UpdateProfilePicSuccess(this.userPic);

  @override
  // TODO: implement props
  List<Object?> get props => [userPic];
}


//UPDATE NAME
class UpdateNameSuccessState extends UpdateInfoStates{

  final String name;

  UpdateNameSuccessState({required this.name});

  @override
  // TODO: implement props
  List<Object?> get props => [name];

}

class UpdateNameLoadingState extends UpdateInfoStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateNameFailureState extends UpdateInfoStates{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}


//ADD TO USER
class AddedPostToUserStateLoading extends UpdateInfoStates{

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class AddedPostToUserStateSuccess extends UpdateInfoStates{

  final List<dynamic> myRecipes;

  AddedPostToUserStateSuccess({required this.myRecipes});

  @override
  // TODO: implement props
  List<Object?> get props => [myRecipes];

}

class AddedPostToUserStateFailure extends UpdateInfoStates{

  final String errMsg;

  AddedPostToUserStateFailure({required this.errMsg});

  @override
  // TODO: implement props
  List<Object?> get props => [errMsg];


}
