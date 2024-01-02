import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/buisness%20layer/blocs/app%20bloc/app_bloc.dart';
import 'package:last/buisness%20layer/blocs/app%20bloc/app_s_e.dart';
import 'package:last/buisness%20layer/blocs/post%20bloc/get_post_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20bloc/get_post_s_e.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/user_bloc.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/user_s_e.dart';
import 'package:last/data%20layer/models/user_model.dart';
import 'package:last/presentation/authentication/login_page.dart';
import 'package:last/presentation/home_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppStatus status = context.select((AppBloc appBloc) => appBloc.state.appStatus);
    GetPostsBloc getPostsBloc = BlocProvider.of<GetPostsBloc>(context);
    if (status == AppStatus.authenticate){
      getPostsBloc.add(GetPostEvent());
      return HomeScreen();
    }else{
      return LoginScreen();
    }
  }
}
