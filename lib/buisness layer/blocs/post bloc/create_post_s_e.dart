import 'package:equatable/equatable.dart';
import 'package:last/data%20layer/models/post_model.dart';

enum GetPostStatus {initial, success, failure, loading}
enum CreatePostStatus{initial, success, failure, loading}

abstract class CreatePostEvents extends Equatable{}

class CreatePostEvent extends CreatePostEvents{
  final Post post;

  CreatePostEvent({required this.post});

  @override
  // TODO: implement props
  List<Object?> get props => [post];

}


abstract class CreatePostStates extends Equatable{}


class CreatePostsState extends CreatePostStates{
  final Post post;
  final CreatePostStatus createPostStatus;

  CreatePostsState({required this.post, required this.createPostStatus});

  CreatePostsState.initial() : this(createPostStatus: CreatePostStatus.initial, post: Post.empty);

  CreatePostsState.loading() : this(createPostStatus: CreatePostStatus.loading, post: Post.empty);

  CreatePostsState.success(Post post) : this(createPostStatus: CreatePostStatus.success, post: post);

  CreatePostsState.failure() : this(createPostStatus: CreatePostStatus.failure, post: Post.empty);

  @override
  // TODO: implement props
  List<Object?> get props => [post, createPostStatus];
}

