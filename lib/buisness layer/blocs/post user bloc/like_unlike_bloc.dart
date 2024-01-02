import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/like_unlike_s_e.dart';

import '../../../data layer/repositories/auth_repo.dart';
import '../../../data layer/repositories/post_repo.dart';

class LikeUnlikeBloc extends Bloc<LikeUnlikePostEvent, LikeUnlikeState>{

  final UserRepository userRepository;
  final PostRepository postRepository;

  LikeUnlikeBloc({required this.userRepository, required this.postRepository}) : super(LikeUnlikeState.initial()){
    on<LikeUnlikePostEvent>((event, emit) async{
      try{
        List<dynamic> mainList = await userRepository.isLiked(event.uid, event.pid);
        await postRepository.likeUnlikePost(mainList[1], event.pid);
        if (mainList[1]) {
          emit(LikeUnlikeState.unlike(mainList[0]));
        }else{
          emit(LikeUnlikeState.like(mainList[0]));
        }
      }catch(e){
        print(e.toString());
        emit(LikeUnlikeState.failure());
      }
    });
  }

}