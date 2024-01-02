import 'package:equatable/equatable.dart';

import '../../data layer/models/post_model.dart';

abstract class SearchEvents extends Equatable{}

class SearchEvent extends SearchEvents{

  final String word;

  SearchEvent({required this.word});

  @override
  // TODO: implement props
  List<Object?> get props => [word];
}

abstract class SearchStates extends Equatable{}

class SearchSuccessState extends SearchStates{

  final List<Post> validPosts;

  SearchSuccessState({required this.validPosts});

  @override
  // TODO: implement props
  List<Object?> get props => [validPosts];
}

class SearchFailEvent extends SearchStates{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchLoadingEvent extends SearchStates{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchInitialEvent extends SearchStates{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
