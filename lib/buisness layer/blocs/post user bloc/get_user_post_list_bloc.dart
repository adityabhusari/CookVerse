import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data layer/models/post_model.dart';
import '../../../data layer/repositories/post_repo.dart';
import 'get_user_post_list_s_e.dart';

class GetUserPostsBloc extends Bloc<GetUserPostEvents, GetUserPostState>{

  final PostRepository postRepository;

  GetUserPostsBloc({required this.postRepository}) : super(GetUserPostState.loading()){
    on<GetUserPostEvent>((event, emit) async{
      emit(GetUserPostState.loading());
      try{
        final List<Post> postList = await postRepository.getUserPosts(event.myRecipes);
        emit(GetUserPostState.success(postList));
      }catch(e){
        print(e.toString());
        emit(GetUserPostState.failure());
      }
    });

  }

}