import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/buisness%20layer/blocs/auth%20bloc/signup_s_e.dart';
import 'package:last/data%20layer/models/user_model.dart';

import '../../../data layer/repositories/auth_repo.dart';

class SignUpBloc extends Bloc<SignUpEvents, SignUpState>{

  final UserRepository userRepository;

  SignUpBloc({required this.userRepository}) : super(SignUpState(userModel: UserModel.empty, status: SignUpStatus.initial)){
    on<SignUpUserEvent>((event, emit) async{
      try{
        UserModel userModel = await userRepository.signUpWithEmailAndPass(event.userModel, event.password);
        await userRepository.setUser(userModel);
        emit(SignUpState(userModel: userModel, status: SignUpStatus.success));
      }catch(e){
       emit(SignUpState(userModel: UserModel.empty, status: SignUpStatus.error));
      }
    });

    on<SignInWithGoogle>((event, emit) async{
      try{
        UserModel userModel = await userRepository.signInWithGoogle(event.userModel);
        await userRepository.setUser(userModel);
        emit(SignUpState(userModel: userModel, status: SignUpStatus.success));
      }catch(e){
        emit(SignUpState(userModel: UserModel.empty, status: SignUpStatus.error));
      }
    });
  }

}