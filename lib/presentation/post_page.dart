import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:last/buisness%20layer/blocs/post%20bloc/create_post_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20bloc/create_post_s_e.dart';
import 'package:last/buisness%20layer/blocs/update%20bloc/update_post_bloc.dart';
import 'package:last/buisness%20layer/blocs/update%20bloc/update_post_s_e.dart';
import 'package:last/buisness%20layer/blocs/update%20bloc/update_user_info_bloc.dart';
import 'package:last/buisness%20layer/blocs/update%20bloc/update_user_info_s_e.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/user_bloc.dart';
import 'package:last/data%20layer/models/post_model.dart';
import 'package:uuid/uuid.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();


}

class _PostScreenState extends State<PostScreen> {
  late Post post;

  final TextEditingController name = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController time = TextEditingController();
  final TextEditingController ingredients = TextEditingController();
  final TextEditingController steps = TextEditingController();


  @override
  void initState() {
    post = Post.empty;
    final String uid = const Uuid().v1();
    post.id = uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;



    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    final CreatePostBloc createPostBloc = BlocProvider.of<CreatePostBloc>(context);
    final UpdatePostBloc updatePostBloc = BlocProvider.of<UpdatePostBloc>(context);
    final UpdateInfoBloc updateInfoBloc =BlocProvider.of<UpdateInfoBloc>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
          children: [
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
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("POST YOUR RECIPE !", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      SizedBox(height: 20,),
                      TextField(
                        controller: name,
                        decoration: InputDecoration(
                            fillColor: Colors.white24,
                            label: Text("Name"),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            )
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextField(
                        controller: type,
                        decoration: InputDecoration(
                            fillColor: Colors.white24,
                            label: Text("Type"),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            )
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextField(
                        controller: time,
                        decoration: InputDecoration(
                            fillColor: Colors.white24,
                            label: Text("Time(mins)"),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            )
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextField(
                        controller: ingredients,
                        minLines: 1,
                        maxLines: null,
                        decoration: InputDecoration(
                            fillColor: Colors.white24,
                            label: Text("Ingredients"),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            )
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextField(
                        controller: steps,
                        minLines: 1,
                        maxLines: null,
                        decoration: InputDecoration(
                            fillColor: Colors.white24,
                            label: Text("Steps"),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            )
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BlocListener<UpdatePostBloc, UpdatePostStates>(
                            listener: (context, state) {
                              if (state is UploadDishPicState){
                                if (state.uploadDishPicStatus == UploadDishPicStatus.success){
                                  setState(() {
                                    post.dishPic = state.dishPic;
                                  });
                                }
                              }
                            },
                            child: BlocListener<CreatePostBloc, CreatePostStates>(
                              listener: (context, state) {
                                if (state is CreatePostsState){
                                  if (state.createPostStatus == CreatePostStatus.success){
                                    updatePostBloc.add(ResetBloc());
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: BlocListener<UpdateInfoBloc, UpdateInfoStates>(
                                listener: (context, state) {
                                  if (state is AddedPostToUserStateSuccess){
                                    setState(() {
                                      userBloc.state.userModel.myRecipes = state.myRecipes;
                                    });
                                  }
                                },
                                child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        post.userId = userBloc.state.userModel.id;
                                        post.name = name.text;
                                        post.type = type.text;
                                        post.ingredients = ingredients.text;
                                        post.time = time.text;
                                        post.steps = steps.text;
                                      });
                                      updateInfoBloc.add(AddPostToUserEvent(postId: post.id, userId: userBloc.state.userModel.id));
                                      createPostBloc.add(CreatePostEvent(post: post));
                                    },
                                    child: Text('POST')
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () async{
                                ImagePicker picker = ImagePicker();
                                XFile? img = await picker.pickImage(
                                    source: ImageSource.gallery,
                                    maxHeight: 500,
                                    maxWidth: 500,
                                    imageQuality: 80
                                );
                                if (img != null){
                                    updatePostBloc.add(UploadDishPicEvent(file: img.path, userId: userBloc.state.userModel.id, postId: post.id));
                                }
                              },
                              child: BlocBuilder<UpdatePostBloc, UpdatePostStates>(
                                  builder: (context, state) {
                                    if (state is UploadDishPicState){
                                      if (state.uploadDishPicStatus == UploadDishPicStatus.loading){
                                        return Center(child: CircularProgressIndicator());
                                      }
                                      else if (state.uploadDishPicStatus == UploadDishPicStatus.success){
                                        return Center(
                                          child: Icon(
                                            Icons.check
                                          ),
                                        );
                                      }
                                      else if (state.uploadDishPicStatus == UploadDishPicStatus.failure){
                                        return Center(
                                          child: Icon(
                                              Icons.clear
                                          ),
                                        );
                                      }else{
                                        return Text("FUKC");
                                      }
                                    }else{
                                      return Text('Upload dish');
                                    }
                                  },

                              )
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ]
      ),
    );
  }
}
