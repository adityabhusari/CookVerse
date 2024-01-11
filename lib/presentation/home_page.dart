import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:last/buisness%20layer/blocs/auth%20bloc/login_s_e.dart';
import 'package:last/buisness%20layer/blocs/auth%20bloc/login_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20bloc/get_post_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20bloc/get_post_s_e.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/get_user_post_list_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/get_user_post_list_s_e.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/like_unlike_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/like_unlike_s_e.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/post_user_inter_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/post_user_s_e.dart';
import 'package:last/buisness%20layer/blocs/update%20bloc/update_user_info_bloc.dart';
import 'package:last/buisness%20layer/blocs/update%20bloc/update_user_info_s_e.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/follow_bloc.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/follow_s_e.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/user_bloc.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/user_s_e.dart';

import '../buisness layer/blocs/search bloc/search bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomeScreen());

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {


    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    PostUserBloc postUserBloc = BlocProvider.of<PostUserBloc>(context);
    FollowerBloc followerBloc = BlocProvider.of<FollowerBloc>(context);
    SearchBloc searchBloc = BlocProvider.of<SearchBloc>(context);

    print('Here${userBloc.state.userModel.name}');
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(-3.5, 1.1),
            child: Container(
              height: width/1.3,
              width: width/1.3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pink.shade100,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-1.6, -1.2),
            child: Container(
              height: width/1.5,
              width: width/1.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300,
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
                color: Colors.blue.shade100,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 75, sigmaY: 75),
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 10, 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              constraints: BoxConstraints(maxWidth: width/1.5),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade700,
                                        offset: const Offset(-2,2),
                                        blurRadius: 2,
                                        spreadRadius: 1
                                    ),
                                  ]
                              ),
                              child: BlocListener<UpdateInfoBloc, UpdateInfoStates>(
                                listener: (context, state) {
                                  if (state is UpdateNameSuccessState){
                                    setState(() {
                                      userBloc.state.userModel.name = state.name;
                                    });
                                  }
                                },
                                child: BlocBuilder<UserBloc, UserState>(
                                  builder: (context, state) {
                                    // print(userBloc.state.userModel.toString());
                                    if (state.userStatus == UserStatus.success){
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(8, 5, 5, 3),
                                        child: Text("WELCOME ${state.userModel.name} !", style: TextStyle(color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.bold, fontSize: 25),overflow: TextOverflow.ellipsis),
                                      );
                                    }else if(state.userStatus == UserStatus.loading){
                                      return Center(child: CircularProgressIndicator());
                                    }else if(state.userStatus == UserStatus.failure){
                                      return Center(child: Text('ERROR'),);
                                    }else{
                                      return Text("PlaceHolder");
                                    }
                                  },
                                ),
                              )
                          ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            followerBloc.add(RestFollowBloc());
                            loginBloc.add(LogoutEvent());
                          },
                          child: Text("LOGOUT"),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<GetPostsBloc, GetPostStates>(
                    builder: (context, state) {
                      if (state is GetPostsState) {
                        if (state.getPostStatus == GetPostStatus.success) {
                          return ListView.builder(
                            itemCount: state.postList.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return userBloc.state.userModel.myRecipes!.contains(state.postList[index].id) ?
                                  Container() :
                               Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10, 0, 10, 30),
                                child: GestureDetector(
                                  onTap: () {
                                    postUserBloc.add(GetUserAndPostModelEvent(uid: state.postList[index].userId!, pid: state.postList[index].id));
                                    Navigator.pushNamed(context, '/recipe');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade600,
                                              offset: const Offset(-1, 2),
                                              blurRadius: 3,
                                              spreadRadius: 2
                                          ),
                                        ]
                                    ),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          child: Image.network(
                                              height: height / 2.1,
                                              width: width,
                                              fit: BoxFit.cover,
                                                state.postList[index].dishPic!
                                            ),
                                          borderRadius: BorderRadius.circular(
                                              10),
                                        ),
                                        Container(
                                          height: height / 2.1,
                                          width: width,
                                          child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                height: height / 7.5,
                                                width: width,
                                                color: Colors.transparent,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .fromLTRB(8, 5, 8, 0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text("${state.postList[index].name}",
                                                        style: TextStyle(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                0.8),
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            fontSize: 25
                                                        ),
                                                      ),
                                                      Text(
                                                        "Posted on ${DateFormat('dd-mm-yyyy').format(state.postList[index].dateTime!)}",
                                                        style: TextStyle(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                0.8),
                                                            fontSize: 15
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              userBloc.state.userModel.myLiked!.contains(state.postList[index].id) ?
                                                              Icon(
                                                                size: 30,
                                                                CupertinoIcons
                                                                    .heart_fill,
                                                                color: Colors
                                                                    .red
                                                                    .withOpacity(
                                                                    0.8),
                                                              ) : Icon(
                                                                size: 30,
                                                                CupertinoIcons
                                                                    .heart,
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                    0.8),
                                                              ),
                                                              SizedBox(
                                                                width: 5,),
                                                              Text("${state.postList[index].likes.toString()}",
                                                                style: TextStyle(
                                                                    fontSize: 20,
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                        0.8)),)
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Icon(
                                                                size: 28,
                                                                CupertinoIcons
                                                                    .clock,
                                                                color: Colors
                                                                    .yellow
                                                                    .withOpacity(
                                                                    0.8),
                                                              ),
                                                              SizedBox(
                                                                width: 5,),
                                                              Text("${state.postList[index].time} mins",
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                        0.8)),)
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                          ),
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.transparent,
                                                    Colors.black87
                                                  ]
                                              ),
                                              borderRadius: BorderRadius
                                                  .circular(10)
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: userBloc.state.userModel.following!.contains(state.postList[index].userId) ? Icon(
                                            size: 40,
                                            CupertinoIcons.star_fill,
                                            color: Colors.yellowAccent,
                                          ) : Icon(
                                            size: 40,
                                            CupertinoIcons.star,
                                            color: Colors.yellowAccent,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }else if(state.getPostStatus == GetPostStatus.failure){
                          return Center(child: Text('Error occured'),);
                        }else if(state.getPostStatus == GetPostStatus.loading){
                          return Center(child: CircularProgressIndicator());
                        }else{
                          return Center(child: Text('Inital'),);
                        }
                      }else{
                        return Center(child: Text("YEEE"));
                      }
                    },
                  ),
                ),
                Container(
                  height: height/13,
                  width: width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1
                    ),
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/post');
                          },
                          child: Icon(
                            size: 40,
                            CupertinoIcons.add_circled_solid,
                            color: Colors.black54,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/search');
                          },
                          child: Icon(
                            size: 40,
                            CupertinoIcons.search,
                            color: Colors.black54,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/profile');
                          },
                          child: Icon(
                            CupertinoIcons.profile_circled,
                            size: 40,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ]
      ),
    );
  }
}
