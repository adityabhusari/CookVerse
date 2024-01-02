import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/get_user_post_list_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/get_user_post_list_s_e.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/post_user_inter_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/post_user_s_e.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/follow_bloc.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/follow_s_e.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/get_user_bloc.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/get_user_s_e.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/user_bloc.dart';
import 'package:last/data%20layer/models/user_model.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();

}

class _UserScreenState extends State<UserScreen> {

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    GetUserBloc getUserBloc = BlocProvider.of<GetUserBloc>(context);
    FollowerBloc followerBloc = BlocProvider.of<FollowerBloc>(context);
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    GetUserPostsBloc getUserPostsBloc = BlocProvider.of<GetUserPostsBloc>(context);
    PostUserBloc postUserBloc = BlocProvider.of<PostUserBloc>(context);


    return Scaffold(
      body: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional(-1.6, -1.2),
              child: Container(
                height: width/1.5,
                width: width/1.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.shade200.withOpacity(0.6),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(3, 0),
              child: Container(
                height: width/1.5,
                width: width/1.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade100.withOpacity(0.6),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 75, sigmaY: 75),
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 40, 10, 0),
              child: BlocBuilder<GetUserBloc, GetUserState>(
                builder: (context, state) {
                  if (state.getUserStatus == GetUserStatus.loading){
                    return Center(child: CircularProgressIndicator());
                  }else if(state.getUserStatus == GetUserStatus.success){
                    getUserPostsBloc.add(GetUserPostEvent(myRecipes: state.userModel.myRecipes!));
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                  size: 30,
                                  CupertinoIcons.back
                              ),
                            ),
                          ),
                          Center(
                              child: state.userModel.photo == "" ?
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                                size: 150,
                                CupertinoIcons.profile_circled
                            ),
                          ) : Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            state.userModel.photo!
                                        )
                                    )
                                ),
                              )
                          ),
                          SizedBox(height: 10,),
                          Center(child: Text(state.userModel.name!, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),
                          SizedBox(height: 20,),
                          BlocConsumer<FollowerBloc, FollowUnState>(
                            listener: (context, followState) {
                              if (followState.followStatus == FollowStatus.unfollow){
                                userBloc.state.userModel.following!.remove(state.userModel.id);
                                // print(userBloc.state.userModel.toString());
                              }else if (followState.followStatus == FollowStatus.follow){
                                userBloc.state.userModel.following!.add(state.userModel.id);
                                // print(userBloc.state.userModel.toString());
                              }
                            },
                            builder: (context, followState) {
                              print(followState.followStatus);
                              if (followState.followStatus == FollowStatus.initial){
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              Text("Followers", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.6))),
                                              Text(state.userModel.followers!.length.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("Following", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.6))),
                                              Text(state.userModel.following!.length.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      state.userModel.followers!.contains(userBloc.state.userModel.id) ?
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.7))
                                          ),
                                          onPressed: () {
                                            followerBloc.add(FollowUnRequestEvent(follower: userBloc.state.userModel.id, user: state.userModel.id));
                                          },
                                          child: Text('Followed', style: TextStyle(color: Colors.blue, fontSize: 18),)
                                      ) : ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStatePropertyAll(Colors.blue.withOpacity(0.7))
                                          ),
                                          onPressed: () {
                                            followerBloc.add(FollowUnRequestEvent(follower: userBloc.state.userModel.id, user: state.userModel.id));
                                          },
                                          child: Text('Follow', style: TextStyle(color: Colors.black, fontSize: 18),)
                                      ),
                                    ],
                                  );
                              }else if(followState.followStatus == FollowStatus.unfollow || followState.followStatus == FollowStatus.follow){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            Text("Followers", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.6))),
                                            Text(followState.noFollowers.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text("Following", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.6))),
                                            Text(state.userModel.following!.length.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    followState.followStatus == FollowStatus.follow ?
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.7))
                                        ),
                                        onPressed: () {
                                          followerBloc.add(FollowUnRequestEvent(follower: userBloc.state.userModel.id, user: state.userModel.id));
                                        },
                                        child: Text('Following', style: TextStyle(color: Colors.blue, fontSize: 18),)
                                    ) : ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStatePropertyAll(Colors.blue.withOpacity(0.7))
                                        ),
                                        onPressed: () {
                                          followerBloc.add(FollowUnRequestEvent(follower: userBloc.state.userModel.id, user: state.userModel.id));
                                        },
                                        child: Text('Follow', style: TextStyle(color: Colors.white, fontSize: 18),)
                                    ),
                                  ],
                                );
                              }else{
                                return Center(child: Text('ERROR'),);
                              }
                            },
                          ),
                          SizedBox(height: 15,),
                          Icon(
                            size: 30,
                            Icons.grid_on,
                            color: Colors.black.withOpacity(0.5),
                          ),
                          Divider(
                            thickness: 3,
                            height: 20,
                          ),
                          BlocBuilder<GetUserPostsBloc, GetUserPostState>(
                            builder: (context, gridState) {
                              if (gridState.getUserPostStatus == GetUserPostStatus.loading){
                                return Center(child: CircularProgressIndicator());
                              }else if (gridState.getUserPostStatus == GetUserPostStatus.success){
                                return GridView.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 5.0,
                                      mainAxisSpacing: 5.0,
                                    ),
                                    itemCount: state.userModel.myRecipes!.length,
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            postUserBloc.add(GetUserAndPostModelEvent(uid: state.userModel.id, pid: gridState.postList[index].id));
                                            Navigator.pushNamed(context, '/recipe');
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      gridState.postList[index].dishPic!
                                                  )
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                );
                              }else{
                                return Center(child: Text('ERROR'),);
                              }
                            },
                          )
                        ],
                      ),
                    );
                  }else{
                    return Center(child: Text('ERROR'),);
                  }
                },
              ),
            ),
          ]
      ),
    );
  }
}
