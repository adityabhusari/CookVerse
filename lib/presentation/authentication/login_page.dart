import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/buisness%20layer/blocs/auth%20bloc/login_s_e.dart';
import 'package:last/buisness%20layer/blocs/auth%20bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginScreen());

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final TextEditingController email = TextEditingController();
    final TextEditingController pass = TextEditingController();

    LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocListener<LoginBloc, LoginStates>(
      listener: (context, state) {
        if (state is LoginState){
          if (state.loginStatus == LoginStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errMsg.toString()), duration: Duration(milliseconds: 1000),)
            );
          }
        }
        if (state is PassResetSent){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Password reset link send to your email!"),  duration: Duration(milliseconds: 1000))
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: height,
            color: Colors.grey.shade300,
            child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(20, -1.2),
                    child: Container(
                      height: width,
                      width: width,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellowAccent,
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
                        color: Colors.red,

                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(1.6, -1.2),
                    child: Container(
                      height: width/1.5,
                      width: width/1.5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,

                      ),
                    ),
                  ),
                  BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                      child: Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          size: 100,
                          color: Colors.white,
                          Icons.local_dining_sharp
                        ),
                        SizedBox(height: 20,),
                        Text("Login", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black12.withOpacity(0.6))),
                        SizedBox(height: 20,),
                        TextField(
                          controller: email,
                          decoration: InputDecoration(
                              fillColor: Colors.white24,
                              label: Text("Email"),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)
                              )
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextField(
                          controller: pass,
                          decoration: InputDecoration(
                              fillColor: Colors.white24,
                              label: Text("Password"),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)
                              )
                          ),
                        ),
                        SizedBox(height: 15,),
                        ElevatedButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(3)
                            ),
                            onPressed: () {
                              loginBloc.add(LoginUserEvent(email: email.text.trim(), password: pass.text.trim()));
                            },
                            child: Text("Login", style: TextStyle(color: Colors.black),)),
                        SizedBox(height: 20),
                        RichText(
                          text: TextSpan(children: [
                            const TextSpan(
                              text: "Don't have an account? ", style: TextStyle(color: Colors.black)
                            ),
                            TextSpan(
                                text: 'Register',
                                style:  TextStyle(
                                  color: Colors.blue,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/register');
                                  }
                            ),
                          ]
                          ),
                        ),
                        SizedBox(height: 10,),
                        RichText(text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Forgot password?',
                                  style:  TextStyle(
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      loginBloc.add(ForgotPassEvent(email: email.text));
                                    }
                              ),
                            ]
                          )),
                      ],
                    ),
                  ),
                ],
              ),
          ),

        ),
      ),
    );
  }
}


