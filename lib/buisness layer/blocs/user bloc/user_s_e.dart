import 'package:equatable/equatable.dart';
import 'package:last/data%20layer/models/user_model.dart';

enum UserStatus {loading, success, failure}

abstract class UserEvents extends Equatable{}

class GetUserModelEvent extends UserEvents{
  final String uid;

  GetUserModelEvent({required this.uid});

  @override
  // TODO: implement props
  List<Object?> get props => [uid];

}

class UserState extends Equatable{

  final UserModel userModel;
  final UserStatus userStatus;

  UserState({required this.userModel, required this.userStatus});

  UserState.success(UserModel userModel) : this(userModel: userModel, userStatus: UserStatus.success);

  UserState.loading() : this(userModel: UserModel.empty, userStatus: UserStatus.loading);

  UserState.failure() : this(userStatus: UserStatus.failure, userModel: UserModel.empty);

  @override
  // TODO: implement props
  List<Object?> get props => [userModel, userStatus];

}