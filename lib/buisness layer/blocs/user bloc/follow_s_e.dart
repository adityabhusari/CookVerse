import 'package:equatable/equatable.dart';

enum FollowStatus {initial, follow, unfollow, failure}

abstract class FollowUnEvents extends Equatable{}

class FollowUnRequestEvent extends FollowUnEvents{

  final String follower;
  final String user;

  FollowUnRequestEvent({required this.follower, required this.user});

  @override
  // TODO: implement props
  List<Object?> get props => [follower, user];
}

class RestFollowBloc extends FollowUnEvents{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class FollowUnState extends Equatable{

  final int noFollowers;
  final FollowStatus followStatus;

  FollowUnState({this.noFollowers = 0, required this.followStatus});

  FollowUnState.initial() : this(followStatus: FollowStatus.initial);

  FollowUnState.follow(int noFollowers) : this(noFollowers: noFollowers, followStatus: FollowStatus.follow);

  FollowUnState.unfollow(int noFollowers) : this(noFollowers: noFollowers, followStatus: FollowStatus.unfollow);

  FollowUnState.failure() : this(followStatus: FollowStatus.failure);

  @override
  // TODO: implement props
  List<Object?> get props => [noFollowers, followStatus];

}