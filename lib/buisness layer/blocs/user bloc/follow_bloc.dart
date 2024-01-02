import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/buisness%20layer/blocs/update%20bloc/update_post_s_e.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/follow_s_e.dart';
import 'package:last/data%20layer/repositories/auth_repo.dart';

class FollowerBloc extends Bloc<FollowUnEvents, FollowUnState>{

  final UserRepository userRepository;

  FollowerBloc({required this.userRepository}) : super(FollowUnState.initial()){
    on<FollowUnRequestEvent>((event, emit) async{
      try{
        List<dynamic> mainList = await userRepository.followUnfollow(event.user, event.follower);
        if (mainList[1]){
          emit(FollowUnState.unfollow(mainList[0]));
        }else{
          emit(FollowUnState.follow(mainList[0]));
        }
      }catch(e){
        print(e.toString());
        emit(FollowUnState.failure());
      }
    });

    on<RestFollowBloc>((event, emit) {
      emit(FollowUnState.initial());
    });
  }

}