import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/buisness%20layer/blocs/auth%20bloc/login_s_e.dart';
import 'package:last/data%20layer/models/user_model.dart';

import '../../../data layer/repositories/auth_repo.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates>{

  final UserRepository userRepository;

  LoginBloc({required this.userRepository}) : super(LoginState(userModel: UserModel.empty, loginStatus: LoginStatus.initial)){
    on<LoginUserEvent>((event, emit) async{
      try{
        await userRepository.logInWithEmailAndPass(event.email, event.password);
      } catch(e){
        emit(LoginState(userModel: UserModel.empty, loginStatus: LoginStatus.error));
      }
    });

    on<LogoutEvent>((event, emit) async{
      try{
        await userRepository.logOut();
      }catch(e){
        emit(LoginState(userModel: UserModel.empty, loginStatus: LoginStatus.error));
      }
    });

    on<ForgotPassEvent>((event, emit) async{
      try{
        await userRepository.forgotPass(event.email);
        emit(PassResetSent());
      }catch(e){
        print(e.toString());
        emit(LoginState(userModel: UserModel.empty, loginStatus: LoginStatus.error));
      }
    });
  }

  @override
  void onTransition(Transition<LoginEvents, LoginStates> transition) {
    print(transition);
    super.onTransition(transition);
  }
}