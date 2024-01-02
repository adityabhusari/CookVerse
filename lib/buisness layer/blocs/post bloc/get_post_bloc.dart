import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20bloc/get_post_s_e.dart';
import 'package:last/data%20layer/models/post_model.dart';

import '../../../data layer/repositories/post_repo.dart';

class GetPostsBloc extends Bloc<GetPostEvent, GetPostsState>{

  final PostRepository postRepository;

  GetPostsBloc({required this.postRepository}) : super(GetPostsState.initial()){
    on<GetPostEvent>((event, emit) async{
      emit(GetPostsState.loading());
      try{
        final List<Post> postList = await postRepository.getPosts();
        emit(GetPostsState.success(postList));
      }catch(e){
        print(e.toString());
        emit(GetPostsState.failure());
      }
    });
  }

}