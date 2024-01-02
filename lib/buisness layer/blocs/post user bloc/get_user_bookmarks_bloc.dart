import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data layer/models/post_model.dart';
import '../../../data layer/repositories/post_repo.dart';
import 'get_user_bookmarks_s_e.dart';
import 'get_user_post_list_s_e.dart';

class GetUserPostsBookMarkBloc extends Bloc<GetUserPostBookMarkEvents, GetUserPostBookmarkState>{

  final PostRepository postRepository;

  GetUserPostsBookMarkBloc({required this.postRepository}) : super(GetUserPostBookmarkState.loading()){
    on<GetUserBookMarkEvent>((event, emit) async{
      emit(GetUserPostBookmarkState.loading());
      try{
        final List<Post> postList = await postRepository.getUserPosts(event.myBookmarks);
        emit(GetUserPostBookmarkState.success(postList));
      }catch(e){
        print(e.toString());
        emit(GetUserPostBookmarkState.failure());
      }
    });

  }

}