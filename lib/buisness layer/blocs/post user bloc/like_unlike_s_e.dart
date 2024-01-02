import 'package:equatable/equatable.dart';

enum LikeUnlikeStatus {initial, like, unlike, failure}

class LikeUnlikePostEvent extends Equatable{

  final String uid;
  final String pid;

  LikeUnlikePostEvent({required this.pid, required this.uid});

  @override
  // TODO: implement props
  List<Object?> get props => [pid, uid];
}

class LikeUnlikeState extends Equatable{

  final List<dynamic> myLiked;
  final LikeUnlikeStatus likeUnlikeStatus;

  LikeUnlikeState({required this.likeUnlikeStatus, this.myLiked = const []});

  LikeUnlikeState.initial() : this(likeUnlikeStatus: LikeUnlikeStatus.initial);

  LikeUnlikeState.like(List<dynamic> myLiked) : this(myLiked: myLiked, likeUnlikeStatus: LikeUnlikeStatus.like);

  LikeUnlikeState.unlike(List<dynamic> myLiked) : this(myLiked: myLiked, likeUnlikeStatus: LikeUnlikeStatus.unlike);

  LikeUnlikeState.failure() : this(likeUnlikeStatus: LikeUnlikeStatus.failure);

  @override
  // TODO: implement props
  List<Object?> get props => [likeUnlikeStatus, myLiked];

}
