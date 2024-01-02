import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/buisness%20layer/blocs/update%20bloc/update_user_info_s_e.dart';

import '../../../data layer/repositories/auth_repo.dart';

class UpdateInfoBloc extends Bloc<UpdateInfoEvents, UpdateInfoStates>{

  final UserRepository userRepository;

  UpdateInfoBloc({required this.userRepository}) : super(UserInfoInitialState()){
    on<UpdateProfilePicEvent>((event, emit) async{
        emit(UpdateProfilePicLoading());
        try{
            String profilePic = await userRepository.updateUserProfilePic(event.file, event.uid);
            emit(UpdateProfilePicSuccess(profilePic));
        }catch(e){
          print(e.toString());
          emit(UpdateProfilePicFailure(e.toString()));
        }
    });

    on<UpdateNameEvent>((event, emit) async{
      emit(UpdateNameLoadingState());
      try{
        String newName = await userRepository.updateUsername(event.name, event.uid);
        emit(UpdateNameSuccessState(name: newName));
      }catch(e){
        print(e.toString());
        emit(UpdateNameFailureState());
      }
    });

    on<AddPostToUserEvent>((event, emit) async{
        emit(AddedPostToUserStateLoading());
        try{
          final List<dynamic> myRecipes = await userRepository.addPostToUser(event.postId, event.userId);
           emit(AddedPostToUserStateSuccess(myRecipes: myRecipes));
        }catch(e){
          print(e.toString());
          emit(AddedPostToUserStateFailure(errMsg: e.toString()));
        }
    });
  }
}