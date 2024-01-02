import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/get_user_bookmarks_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/get_user_bookmarks_s_e.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/get_user_post_list_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/post_user_inter_bloc.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/user_s_e.dart';
import 'package:last/presentation/authentication/login_page.dart';

import '../buisness layer/blocs/auth bloc/login_bloc.dart';
import '../buisness layer/blocs/auth bloc/login_s_e.dart';
import '../buisness layer/blocs/post user bloc/get_user_post_list_s_e.dart';
import '../buisness layer/blocs/post user bloc/post_user_s_e.dart';
import '../buisness layer/blocs/update bloc/update_user_info_bloc.dart';
import '../buisness layer/blocs/update bloc/update_user_info_s_e.dart';
import '../buisness layer/blocs/user bloc/follow_bloc.dart';
import '../buisness layer/blocs/user bloc/follow_s_e.dart';
import '../buisness layer/blocs/user bloc/user_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin{

  late TabController tabController;
  late bool isPressed;

  TextEditingController name = TextEditingController();

  @override
  void initState() {
    isPressed = false;
    super.initState();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    UpdateInfoBloc updateInfoBloc = BlocProvider.of<UpdateInfoBloc>(context);
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    GetUserPostsBloc getUserPostsBloc = BlocProvider.of<GetUserPostsBloc>(context);
    GetUserPostsBookMarkBloc getUserPostsBookMarkBloc = BlocProvider.of<GetUserPostsBookMarkBloc>(context);
    PostUserBloc postUserBloc = BlocProvider.of<PostUserBloc>(context);

    return BlocListener<UpdateInfoBloc, UpdateInfoStates>(
        listener: (context, state) {
            if (state is UpdateProfilePicSuccess){
              setState(() {
                userBloc.state.userModel.photo = state.userPic;
              });
            }
            else if (state is UpdateNameSuccessState){
              setState(() {
                userBloc.state.userModel.name = state.name;
              });
            }
          },
        child: Scaffold(
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
                padding: const EdgeInsets.fromLTRB(15, 50, 10, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        ],
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: GestureDetector(
                          onTap: () async{
                            ImagePicker picker = ImagePicker();
                            XFile? img = await picker.pickImage(
                                source: ImageSource.gallery,
                                maxHeight: 1000,
                                maxWidth: 1000,
                                imageQuality: 80
                            );
                            // if (img != null) {
                            //   print("In");
                            //   CroppedFile? croppedFile = await ImageCropper().
                            //   cropImage(
                            //       sourcePath: img.path,
                            //       aspectRatio: CropAspectRatio(
                            //         ratioX: 1,
                            //         ratioY: 1,
                            //       ),
                            //       aspectRatioPresets: [
                            //         CropAspectRatioPreset.square
                            //       ],
                            //       uiSettings: [
                            //         AndroidUiSettings(
                            //             toolbarTitle: 'Cropper',
                            //             toolbarColor: Colors.white,
                            //             toolbarWidgetColor: Colors.white,
                            //             initAspectRatio: CropAspectRatioPreset
                            //                 .original,
                            //             lockAspectRatio: false
                            //         )
                            //       ]
                            //   );
                            //   print("DOne");
                              if (img != null) {
                                setState(() {
                                  updateInfoBloc.add(
                                      UpdateProfilePicEvent(
                                          uid: userBloc.state.userModel.id,
                                          file: img.path)
                                  );
                                });
                              }
                          },
                          child: BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                              if (state.userStatus == UserStatus.success){
                                getUserPostsBloc.add(GetUserPostEvent(myRecipes: userBloc.state.userModel.myRecipes!));
                                getUserPostsBookMarkBloc.add(GetUserBookMarkEvent(myBookmarks: userBloc.state.userModel.myBookmarks!));
                                name.text = state.userModel.name!;
                                return state.userModel.photo == "" ?
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
                                );
                              }else if (state.userStatus == UserStatus.loading){
                                return Center(child: CircularProgressIndicator());
                              }
                              else{
                                return Text("ERROR");
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),

                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state.userStatus == UserStatus.success){
                            return isPressed ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: TextField(
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
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isPressed = !isPressed;
                                      updateInfoBloc.add(UpdateNameEvent(name: name.text, uid: userBloc.state.userModel.id));
                                    });
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                        color: Colors.blue,
                                        Icons.check
                                    ),
                                  ),
                                )
                              ],
                            ) : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(state.userModel.name!, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isPressed = !isPressed;
                                    });
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                        color: Colors.blue,
                                        Icons.edit
                                    ),
                                  ),
                                )
                              ],
                            );
                          }else if (state.userStatus == UserStatus.loading){
                            return Center(child: CircularProgressIndicator());
                          }else{
                            return Text("ERROR");
                          }
                        },
                      ),
                      SizedBox(height: 30,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text("Followers", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.6))),
                                  Text(userBloc.state.userModel.followers!.length.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
                                ],
                              ),
                              Column(
                                children: [
                                  Text("Following", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.6))),
                                  Text(userBloc.state.userModel.following!.length.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 30,),
                          Container(
                            height: height/2,
                            child: Column(
                              children: [
                                TabBar(
                                    controller: tabController,
                                    tabs: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                            size: 30,
                                            Icons.grid_on
                                        )
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                              size: 30,
                                              Icons.bookmark_border
                                          )
                                      ),
                                  ]
                                ),
                                SizedBox(height: 10),
                                Expanded(
                                  child: TabBarView(
                                      controller: tabController,
                                      children: [
                                        BlocBuilder<GetUserPostsBloc, GetUserPostState>(
                                          builder: (context, state) {
                                            if (state.getUserPostStatus == GetUserPostStatus.success){
                                              return GridView.builder(
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    crossAxisSpacing: 5.0,
                                                    mainAxisSpacing: 5.0,
                                                  ),
                                                  itemCount: state.postList.length,
                                                  physics: ScrollPhysics(),
                                                  shrinkWrap: true,
                                                  scrollDirection: Axis.vertical,
                                                  itemBuilder: (context, index) {
                                                    return Padding(
                                                      padding: const EdgeInsets.all(1.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          postUserBloc.add(GetUserAndPostModelEvent(uid: state.postList[index].userId!, pid: state.postList[index].id));
                                                          Navigator.pushNamed(context, '/recipe');
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5),
                                                            image: DecorationImage(
                                                                fit: BoxFit.cover,
                                                                image: NetworkImage(
                                                                    state.postList[index].dishPic!
                                                                )
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                              );
                                            }else if(state.getUserPostStatus == GetUserPostStatus.loading){
                                              return Center(child: CircularProgressIndicator(),);
                                            }else{
                                              return Center(child: Text('ERROR'),);
                                            }
                                          },
                                        ),
                                        BlocBuilder<GetUserPostsBookMarkBloc, GetUserPostBookmarkState>(
                                          builder: (context, state) {
                                            if (state.getUserPostBookmarkStatus == GetUserPostBookmarkStatus.success){
                                              return GridView.builder(
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    crossAxisSpacing: 5.0,
                                                    mainAxisSpacing: 5.0,
                                                  ),
                                                  itemCount: state.postList.length,
                                                  physics: ScrollPhysics(),
                                                  shrinkWrap: true,
                                                  scrollDirection: Axis.vertical,
                                                  itemBuilder: (context, index) {
                                                    return Padding(
                                                      padding: const EdgeInsets.all(1.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          postUserBloc.add(GetUserAndPostModelEvent(uid: state.postList[index].userId!, pid: state.postList[index].id));
                                                          Navigator.pushNamed(context, '/recipe');
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5),
                                                            image: DecorationImage(
                                                                fit: BoxFit.cover,
                                                                image: NetworkImage(
                                                                    state.postList[index].dishPic!
                                                                )
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                              );
                                            }else if(state.getUserPostBookmarkStatus == GetUserPostBookmarkStatus.loading){
                                              return Center(child: CircularProgressIndicator(),);
                                            }else{
                                              return Center(child: Text('ERROR'),);
                                            }
                                          },
                                        ),
                                      ]
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ),
        )
      );
  }
}
