import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/bookmark_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/bookmark_s_e.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/like_unlike_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/like_unlike_s_e.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/post_user_inter_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/post_user_s_e.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/get_user_bloc.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/get_user_s_e.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/user_bloc.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    PostUserBloc postUserBloc = BlocProvider.of<PostUserBloc>(context);
    LikeUnlikeBloc likeUnlikeBloc = BlocProvider.of<LikeUnlikeBloc>(context);
    BookMarkBloc bookMarkBloc = BlocProvider.of<BookMarkBloc>(context);
    GetUserBloc getUserBloc = BlocProvider.of<GetUserBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("RECIPE", style: TextStyle(color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.bold, fontSize: 28),),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(-3.5, 1.1),
                child: Container(
                  height: width/1.3,
                  width: width/1.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow.shade200,
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
                    color: Colors.red.shade200,
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
                    color: Colors.blue.shade200,
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 75, sigmaY: 75),
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
                child: BlocBuilder<PostUserBloc, PostUserStates>(
                  builder: (context, state) {
                    if (state is GetUserAndPostState){
                      if (state.getUserForPostStatus == GetUserForPostStatus.success){
                        return Column(
                          children: [
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  getUserBloc.add(GetUserEvent(uid: state.postModel.userId!));
                                  Navigator.pushReplacementNamed(context, '/user');
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.profile_circled,
                                    ),
                                    SizedBox(width: 8,),
                                    Text("${state.userModel.name}", style: TextStyle(fontSize: 15),)
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: height/1.5,
                              width: width,
                              decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade400,
                                        offset: const Offset(-1,2),
                                        blurRadius: 3,
                                        spreadRadius: 2
                                    ),
                                  ]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Name:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.35)),),
                                        Text(state.postModel.name!)
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Duration:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.35)),),
                                        Text('${state.postModel.time!} mins')
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Type:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.35)),),
                                        Text(state.postModel.type!)
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Ingredients:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.35)),),
                                        Text(state.postModel.ingredients!)
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Steps:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.35)),),
                                        Text(state.postModel.steps!)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              likeUnlikeBloc.add(LikeUnlikePostEvent(pid: state.postModel.id, uid: userBloc.state.userModel.id));
                                            },
                                            child: BlocConsumer<LikeUnlikeBloc, LikeUnlikeState>(
                                              listener: (context, likeUnlikeState) {
                                                if (likeUnlikeState.likeUnlikeStatus == LikeUnlikeStatus.like ||
                                                    likeUnlikeState.likeUnlikeStatus == LikeUnlikeStatus.unlike){
                                                      userBloc.state.userModel.myLiked = likeUnlikeState.myLiked;
                                                      print(userBloc.state.userModel.toString());
                                                  }
                                                },
                                              builder: (context, likeUnlikeState) {
                                                if (likeUnlikeState.likeUnlikeStatus == LikeUnlikeStatus.initial){
                                                  if (userBloc.state.userModel.myLiked!.contains(state.postModel.id)){
                                                    return Icon(
                                                      size: 30,
                                                      CupertinoIcons.heart_fill,
                                                      color: Colors.red,
                                                    );
                                                  }else{
                                                    return Icon(
                                                        size: 30,
                                                        CupertinoIcons.heart
                                                    );
                                                  }
                                                }
                                                if (likeUnlikeState.likeUnlikeStatus == LikeUnlikeStatus.like){
                                                  return Icon(
                                                      size: 30,
                                                      CupertinoIcons.heart_fill,
                                                      color: Colors.red,
                                                  );
                                                }else if(likeUnlikeState.likeUnlikeStatus == LikeUnlikeStatus.unlike){
                                                  return Icon(
                                                      size: 30,
                                                      CupertinoIcons.heart
                                                  );
                                                }else{
                                                  return Icon(
                                                      size: 30,
                                                      CupertinoIcons.heart
                                                  );
                                              }
                                                },
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              bookMarkBloc.add(BookMarkEvent(pid: state.postModel.id, uid: userBloc.state.userModel.id));
                                            },
                                            child: BlocConsumer<BookMarkBloc, BookMarkState>(
                                              listener: (context, bookmarkState) {
                                                if (bookmarkState.bookMarkStatus == BookMarkStatus.mark ||
                                                    bookmarkState.bookMarkStatus == BookMarkStatus.unMark){
                                                  userBloc.state.userModel.myBookmarks = bookmarkState.myBookmarks;
                                                  print(userBloc.state.userModel.toString());
                                                }
                                              },
                                              builder: (context, bookmarkState) {
                                                if (bookmarkState.bookMarkStatus == BookMarkStatus.initial){
                                                  if (userBloc.state.userModel.myBookmarks!.contains(state.postModel.id)){
                                                    return Icon(
                                                      size: 30,
                                                      CupertinoIcons.bookmark_fill,
                                                      color: Colors.green,
                                                    );
                                                  }else{
                                                    return Icon(
                                                        size: 30,
                                                        CupertinoIcons.bookmark
                                                    );
                                                  }
                                                }
                                                if (bookmarkState.bookMarkStatus == BookMarkStatus.mark){
                                                  return Icon(
                                                    size: 30,
                                                    CupertinoIcons.bookmark_fill,
                                                    color: Colors.green,
                                                  );
                                                }else if(bookmarkState.bookMarkStatus == BookMarkStatus.unMark){
                                                  return Icon(
                                                      size: 30,
                                                      CupertinoIcons.bookmark
                                                  );
                                                }else{
                                                  return Icon(
                                                      size: 30,
                                                      CupertinoIcons.bookmark
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      }else if(state.getUserForPostStatus == GetUserForPostStatus.loading){
                        return Center(child: CircularProgressIndicator(),);
                      }else{
                        return Center(child: Text("ERROR"),);
                      }
                    }else{
                      return Center(child: Text("WILL check Later lol"),);
                    }
                  },
                ),
              ),
            ]
        ),
      ),
    );
  }
}
