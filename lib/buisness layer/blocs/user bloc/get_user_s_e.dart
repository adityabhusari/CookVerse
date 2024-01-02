import 'package:equatable/equatable.dart';
import 'package:last/data%20layer/models/user_model.dart';

enum GetUserStatus {loading, success, failure}

abstract class GetUserEvents extends Equatable{}

class GetUserEvent extends GetUserEvents{
  final String uid;

  GetUserEvent({required this.uid});

  @override
  // TODO: implement props
  List<Object?> get props => [uid];

}

class GetUserState extends Equatable{

  final UserModel userModel;
  final GetUserStatus getUserStatus;

  GetUserState({required this.userModel, required this.getUserStatus});

  GetUserState.success(UserModel userModel) : this(userModel: userModel, getUserStatus: GetUserStatus.success);

  GetUserState.loading() : this(userModel: UserModel.empty, getUserStatus: GetUserStatus.loading);

  GetUserState.failure() : this(getUserStatus: GetUserStatus.failure, userModel: UserModel.empty);

  @override
  // TODO: implement props
  List<Object?> get props => [userModel, getUserStatus];

}