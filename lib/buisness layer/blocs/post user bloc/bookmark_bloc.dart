import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/bookmark_s_e.dart';

import '../../../data layer/repositories/auth_repo.dart';
import '../../../data layer/repositories/post_repo.dart';

class BookMarkBloc extends Bloc<BookMarkEvent, BookMarkState>{

  final UserRepository userRepository;
  final PostRepository postRepository;

  BookMarkBloc({required this.userRepository, required this.postRepository}) : super(BookMarkState.initial()){
    on<BookMarkEvent>((event, emit) async{
      try{
        List<dynamic> mainList = await userRepository.isBookmarked(event.uid, event.pid);
        if (mainList[1]) {
          emit(BookMarkState.unMark(mainList[0]));
        }else{
          emit(BookMarkState.mark(mainList[0]));
        }
      }catch(e){
        print(e.toString());
        emit(BookMarkState.failure());
      }
    });
  }

}