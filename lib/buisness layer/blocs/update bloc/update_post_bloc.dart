import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/buisness%20layer/blocs/update%20bloc/update_post_s_e.dart';
import 'package:last/data%20layer/repositories/post_repo.dart';

class UpdatePostBloc extends Bloc<UpdatePostEvents, UpdatePostStates>{
  final PostRepository postRepository;

  UpdatePostBloc({required this.postRepository}) : super(UpdatePostStateInitial()){
    on<UploadDishPicEvent>((event, emit) async{
      emit(UploadDishPicState.loading());
        try{
          final String dishPic = await postRepository.uploadDishPic(event.file, event.postId, event.userId);
          emit(UploadDishPicState.success(dishPic));
        }catch(e){
          print(e.toString());
          emit(UploadDishPicState.failure());
        }
    });

    on<ResetBloc>((event, emit) {
      emit(UpdatePostStateInitial());
    });
  }
}