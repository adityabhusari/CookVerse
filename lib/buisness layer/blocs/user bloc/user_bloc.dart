import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/user_s_e.dart';
import 'package:last/data%20layer/models/user_model.dart';

import '../../../data layer/repositories/auth_repo.dart';

class UserBloc extends Bloc<UserEvents, UserState>{

  final UserRepository userRepository;
  late StreamSubscription streamSubscription;

  UserBloc({required this.userRepository}) : super(UserState.loading()){
    on<GetUserModelEvent>((event, emit) async{
      emit(UserState.loading());
      try{
        final UserModel user = await userRepository.getUser(event.uid);
        emit(UserState.success(user));
      }catch(e){
        print(e.toString());
        emit(UserState.failure());
      }
    });
    
    streamSubscription = userRepository.userStream.listen((UserModel userModel) {
      add(GetUserModelEvent(uid: userModel.id));
    });
    

  }
  // @override
  // void onTransition(Transition<UserEvents, UserState> transition) {
  //   print(transition);
  //   super.onTransition(transition);
  // }
  // @override
  // void onChange(Change<UserState> transition) {
  //   print(transition);
  //   super.onChange(transition);
  // }

  @override
  Future<void> close() {
    super.close();
    return streamSubscription.cancel();
  }
}