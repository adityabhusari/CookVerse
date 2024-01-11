import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:last/data%20layer/models/user_model.dart';

enum SignUpStatus {initial, submitting, success, error}

abstract class SignUpEvents extends Equatable{}

//EVENTS
class SignUpUserEvent extends SignUpEvents{
  final UserModel userModel;
  final String password;

  SignUpUserEvent({required this.password, required this.userModel});

  @override
  // TODO: implement props
  List<Object?> get props => [password, userModel];

}

class SignInWithGoogle extends SignUpEvents{

  final UserModel userModel;

  SignInWithGoogle({required this.userModel});

  @override
  // TODO: implement props
  List<Object?> get props => [userModel];
}

//STATES
class SignUpState extends Equatable{
  final UserModel userModel;
  final SignUpStatus status;
  final String? errMsg;

  SignUpState({required this.userModel, required this.status, this.errMsg});

  @override
  // TODO: implement props
  List<Object?> get props => [userModel, status, errMsg];

}