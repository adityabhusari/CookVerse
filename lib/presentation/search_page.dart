import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/post_user_inter_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/post_user_s_e.dart';
import 'package:last/buisness%20layer/blocs/search%20bloc/search%20bloc.dart';
import 'package:last/buisness%20layer/blocs/search%20bloc/search_s_e.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    SearchBloc searchBloc = BlocProvider.of<SearchBloc>(context);
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
              padding: const EdgeInsets.fromLTRB(15, 60, 10, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: search,
                      onChanged: (value) {
                        searchBloc.add(SearchEvent(word: value.toLowerCase()));
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          fillColor: Colors.white24,
                          label: Text("Search"),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: BlocBuilder<SearchBloc, SearchStates>(
                        builder: (context, state) {
                          if (state is SearchSuccessState){
                            return ListView.builder(
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: state.validPosts.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade400,
                                              offset: const Offset(-1, 3),
                                              blurRadius: 2,
                                              spreadRadius: 1
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 5, 5, 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          postUserBloc.add(GetUserAndPostModelEvent(uid: state.validPosts[index].userId!, pid: state.validPosts[index].id));
                                          Navigator.pushNamed(context, '/recipe');
                                        },
                                        child: ListTile(
                                          leading: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      state.validPosts[index].dishPic!
                                                  )
                                              )
                                            ),
                                          ),
                                          title: Text(state.validPosts[index].name!),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }else if (state is SearchLoadingEvent){
                            return Center(child: CircularProgressIndicator(),);
                          }else if (state is SearchInitialEvent){
                            return Container(
                                height: height/2,
                                child: Center(child: Text('Search'),)
                            );
                          }else{
                            return Center(child: Text('ERROR WHILE SEARCHING'),);
                          }
                        },
                      ),
                    )
                  ]
                ),
              ),
            ),
          ]
      ),
    );
  }
}
