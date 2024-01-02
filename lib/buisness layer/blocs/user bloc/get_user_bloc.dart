import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/get_user_s_e.dart';

import '../../../data layer/models/user_model.dart';
import '../../../data layer/repositories/auth_repo.dart';

class GetUserBloc extends Bloc<GetUserEvents, GetUserState>{

  final UserRepository userRepository;

  GetUserBloc({required this.userRepository}) : super(GetUserState.loading()){
    on<GetUserEvent>((event, emit) async{
      try{
        final UserModel user = await userRepository.getUser(event.uid);
        emit(GetUserState.success(user));
      }catch(e){
        print(e.toString());
        emit(GetUserState.failure());
      }
    });
  }
}