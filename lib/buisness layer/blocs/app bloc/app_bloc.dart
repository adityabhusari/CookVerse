import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data layer/models/user_model.dart';
import '../../../data layer/repositories/auth_repo.dart';
import 'app_s_e.dart';

class AppBloc extends Bloc<AppEvents, AppState>{

  final UserRepository userRepository;
  late final StreamSubscription<UserModel?> userStreamSubscription;

  AppBloc({required this.userRepository}) : super(userRepository.getCurrUserModel.isNotEmpty ?
  AppState.authenticate(userRepository.getCurrUserModel) :  AppState.unauthenticate()){
    on<AppUserChangedEvent>((event, emit) {
        emit(event.user.isNotEmpty ? AppState.authenticate(event.user) :  AppState.unauthenticate());
    });

    userStreamSubscription = userRepository.userStream.listen((UserModel userModel) {
      add(AppUserChangedEvent(user: userModel));
    });

    on<AppUserLogOutEvent>((event, emit) {
        userRepository.logOut();
    });

  }
  @override
  Future<void> close() {
    super.close();
    return userStreamSubscription.cancel();
  }
}