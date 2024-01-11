import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/buisness%20layer/blocs/auth%20bloc/login_bloc.dart';
import 'package:last/buisness%20layer/blocs/auth%20bloc/signup_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20bloc/create_post_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20bloc/get_post_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20bloc/get_post_s_e.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/bookmark_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/get_user_bookmarks_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/get_user_post_list_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/like_unlike_bloc.dart';
import 'package:last/buisness%20layer/blocs/post%20user%20bloc/post_user_inter_bloc.dart';
import 'package:last/buisness%20layer/blocs/search%20bloc/search%20bloc.dart';
import 'package:last/buisness%20layer/blocs/update%20bloc/update_post_bloc.dart';
import 'package:last/buisness%20layer/blocs/update%20bloc/update_user_info_bloc.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/follow_bloc.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/get_user_bloc.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/user_bloc.dart';
import 'package:last/buisness%20layer/blocs/user%20bloc/user_s_e.dart';
import 'package:last/data%20layer/repositories/post_repo.dart';
import 'package:last/firebase_options.dart';
import 'package:last/presentation/authentication/login_page.dart';
import 'package:last/presentation/search_page.dart';
import 'package:last/presentation/authentication/signup_page.dart';
import 'package:last/presentation/user_page.dart';
import 'package:last/presentation/authentication/wrapper.dart';
import 'package:last/presentation/home_page.dart';
import 'package:last/presentation/post_page.dart';
import 'package:last/presentation/recipe_page.dart';
import 'package:last/presentation/user_profile_page.dart';
import 'buisness layer/blocs/app bloc/app_bloc.dart';
import 'data layer/repositories/auth_repo.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(MyApp(userRepository: UserRepository(), postRepository: PostRepository(),));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final PostRepository postRepository;
  const MyApp({required this.userRepository, required this.postRepository,super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
          BlocProvider<AppBloc>(create: (context) => AppBloc(userRepository: userRepository)),
          BlocProvider<LoginBloc>(create: (context) => LoginBloc(userRepository: userRepository),),
          BlocProvider<SignUpBloc>(create: (context) => SignUpBloc(userRepository: userRepository),),
          BlocProvider<UserBloc>(create: (context) => UserBloc(userRepository: userRepository),),
          BlocProvider<UpdateInfoBloc>(create: (context) => UpdateInfoBloc(userRepository: userRepository),),
          BlocProvider<CreatePostBloc>(create: (context) => CreatePostBloc(postRepository: postRepository),),
          BlocProvider<UpdatePostBloc>(create: (context) => UpdatePostBloc(postRepository: postRepository),),
          BlocProvider<GetPostsBloc>(create: (context) => GetPostsBloc(postRepository: postRepository)..add(GetPostEvent()),),
          BlocProvider<PostUserBloc>(create: (context) => PostUserBloc(userRepository: userRepository, postRepository: postRepository),),
          BlocProvider<LikeUnlikeBloc>(create: (context) => LikeUnlikeBloc(userRepository: userRepository, postRepository: postRepository),),
          BlocProvider<BookMarkBloc>(create: (context) => BookMarkBloc(userRepository: userRepository, postRepository: postRepository),),
          BlocProvider<GetUserBloc>(create: (context) => GetUserBloc(userRepository: userRepository),),
          BlocProvider<FollowerBloc>(create: (context) => FollowerBloc(userRepository: userRepository),),
          BlocProvider<GetUserPostsBloc>(create: (context) => GetUserPostsBloc(postRepository: postRepository),),
          BlocProvider<GetUserPostsBookMarkBloc>(create: (context) => GetUserPostsBookMarkBloc(postRepository: postRepository),),
          BlocProvider<SearchBloc>(create: (context) => SearchBloc(postRepository: postRepository),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
          '/register': (context) => SignUpScreen(),
          '/recipe': (context) => RecipePage(),
          '/profile': (context) => ProfileScreen(),
          '/post': (context) => PostScreen(),
          '/user': (context) => UserScreen(),
          '/search': (context) => SearchScreen()
        },
      ),
    );
  }
}

