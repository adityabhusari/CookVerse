import 'package:equatable/equatable.dart';
import '../../../data layer/models/user_model.dart';

enum AppStatus{
  authenticate,
  unAuthenticate
}

//EVENTS
abstract class AppEvents extends Equatable{}

class AppUserLogOutEvent extends AppEvents{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AppUserChangedEvent extends AppEvents{
  final UserModel user;

  AppUserChangedEvent({required this.user});

  @override
  // TODO: implement props
  List<Object?> get props => [user];

}

//STATES
class AppState extends Equatable{

  final UserModel user;
  final AppStatus appStatus;

   AppState({required this.user, required this.appStatus});

   AppState.authenticate(UserModel user) : this(user: user, appStatus: AppStatus.authenticate);

   AppState.unauthenticate() : this(user: UserModel.empty ,appStatus: AppStatus.unAuthenticate);

  @override
  // TODO: implement props
  List<Object?> get props => [user, appStatus];

}