import 'package:equatable/equatable.dart';
import 'package:last/data%20layer/models/user_model.dart';

enum LoginStatus {initial , submitting, success, error}

//EVENTS
abstract class LoginEvents extends Equatable{}

class LoginUserEvent extends LoginEvents{
  final String email;
  final String password;

  LoginUserEvent({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}

class LogoutEvent extends LoginEvents{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class ForgotPassEvent extends LoginEvents{
  final String email;

  ForgotPassEvent({required this.email});

  @override
  // TODO: implement props
  List<Object?> get props => [];

}


//STATES
abstract class LoginStates extends Equatable{}

class PassResetSent extends LoginStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginState extends LoginStates{
  final UserModel userModel;
  final LoginStatus loginStatus;
  final String? errMsg;

   LoginState({required this.userModel, required this.loginStatus, this.errMsg});

  @override
  // TODO: implement props
  List<Object?> get props => [userModel, loginStatus, errMsg];
}