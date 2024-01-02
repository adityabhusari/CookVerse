import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/post_user_s_e.dart';
import 'package:last/data%20layer/models/post_model.dart';

import '../../../data layer/models/user_model.dart';
import '../../../data layer/repositories/auth_repo.dart';
import '../../../data layer/repositories/post_repo.dart';

class PostUserBloc extends Bloc<PostUserEvents, PostUserStates>{

  final UserRepository userRepository;
  final PostRepository postRepository;

  PostUserBloc({required this.userRepository, required this.postRepository}) : super(PostUserStateInitial()){
    on<GetUserAndPostModelEvent>((event, emit) async{
      emit(GetUserAndPostState.loading());
      try{
        final UserModel user = await userRepository.getUser(event.uid);
        final Post post = await postRepository.getPost(event.pid);
        emit(GetUserAndPostState.success(user, post));
      }catch(e){
        print(e.toString());
        emit(GetUserAndPostState.failure());
      }
    });
  }

}