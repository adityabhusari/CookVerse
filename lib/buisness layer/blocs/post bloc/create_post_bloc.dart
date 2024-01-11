import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20bloc/create_post_s_e.dart';

import '../../../data layer/models/post_model.dart';
import '../../../data layer/repositories/post_repo.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostsState>{

  final PostRepository postRepository;

  CreatePostBloc({required this.postRepository}) : super(CreatePostsState.initial()){
    on<CreatePostEvent>((event, emit) async{
      emit(CreatePostsState.loading());
      try{
        final Post post = await postRepository.createPost(event.post);
        emit(CreatePostsState.success(post));
      }catch(e){
        print(e.toString());
        emit(CreatePostsState.failure());
      }
    });
  }

}