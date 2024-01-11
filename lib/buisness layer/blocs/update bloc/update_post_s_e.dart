import 'package:equatable/equatable.dart';

enum UploadDishPicStatus {loading, success, failure}
enum UploadDishTutStatus {loading, success, failure}

abstract class UpdatePostEvents extends Equatable{}

class ResetBloc extends UpdatePostEvents{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class UploadDishPicEvent extends UpdatePostEvents{
  final String file;
  final String postId;
  final String userId;

  UploadDishPicEvent({required this.file, required this.userId, required this.postId});

  @override
  // TODO: implement props
  List<Object?> get props => [file, postId, userId];

}

class UploadDishTutEvent extends UpdatePostEvents{
  final String file;
  final String postId;
  final String userId;

  UploadDishTutEvent({required this.file, required this.userId, required this.postId});

  @override
  // TODO: implement props
  List<Object?> get props => [file, postId, userId];

}


abstract class UpdatePostStates extends Equatable{}

class UpdatePostStateInitial extends UpdatePostStates{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}




class UploadDishPicState extends UpdatePostStates{

  final String dishPic;
  final UploadDishPicStatus uploadDishPicStatus;

  UploadDishPicState({this.dishPic = '', required this.uploadDishPicStatus});

  UploadDishPicState.loading() : this(uploadDishPicStatus: UploadDishPicStatus.loading);

  UploadDishPicState.success(String dishPic) : this(dishPic: dishPic, uploadDishPicStatus: UploadDishPicStatus.success);

  UploadDishPicState.failure() : this(uploadDishPicStatus: UploadDishPicStatus.failure);

  @override
  // TODO: implement props
  List<Object?> get props => [dishPic, uploadDishPicStatus];

}

class UploadDishTutState extends UpdatePostStates{

  final String dishTut;
  final UploadDishTutStatus uploadDishTutStatus;

  UploadDishTutState({this.dishTut = '', required this.uploadDishTutStatus});

  UploadDishTutState.loading() : this(uploadDishTutStatus: UploadDishTutStatus.loading);

  UploadDishTutState.success(String dishTut) : this(dishTut: dishTut, uploadDishTutStatus: UploadDishTutStatus.success);

  UploadDishTutState.failure() : this(uploadDishTutStatus: UploadDishTutStatus.failure);

  @override
  // TODO: implement props
  List<Object?> get props => [dishTut, uploadDishTutStatus];

}