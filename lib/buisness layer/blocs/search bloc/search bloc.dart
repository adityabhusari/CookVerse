import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/buisness%20layer/blocs/search%20bloc/search_s_e.dart';
import 'package:last/data%20layer/models/post_model.dart';

import '../../../data layer/repositories/post_repo.dart';

class SearchBloc extends Bloc<SearchEvents, SearchStates>{


  final PostRepository postRepository;

  SearchBloc({required this.postRepository}) : super(SearchInitialEvent()) {

    on<SearchEvent>((event, emit) async{
      try{
          List<Post> validPosts = [];
          final List<Post> postList = await postRepository.getPosts();
          for (Post post in postList){
            if (post.name!.toLowerCase()!.contains(event.word)){
              validPosts.add(post);
            }
          }
          emit(SearchSuccessState(validPosts: validPosts));
      }catch(e){
        print(e.toString());
        emit(SearchFailEvent());
      }
    });
  }

}