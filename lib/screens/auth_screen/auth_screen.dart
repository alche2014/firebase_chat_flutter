import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_chat/screens/auth_screen/widgets/input_field.dart';
import 'package:firebase_chat/widgets/tab_title.dart';

import '../../consts.dart';


class AuthScreen extends StatelessWidget {
    TabController _controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
       Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image(
                  image: AssetImage(
                MediaQuery.of(context).platformBrightness == Brightness.light
                    ? 'assets/images/Logo_light.png'
                    : 'assets/images/Logo_dark.png',
              )),
            ),
          ),
          Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
            // backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.transparent,
              bottom: TabBar(
                controller: _controller,
                labelColor: MediaQuery.of(context).platformBrightness ==
                        Brightness.light
                    ? kContentColorLightTheme
                    : kContentColorDarkTheme,
                tabs: [
                  Tab(text: 'Log in'),
                  Tab(
                    text: 'Sign Up',
                  )
                ],
              ),
            ),
            body: TabBarView(
              controller: _controller,
              children: [
                SignInScreen(),
                 SignInScreen()
                // LogIn(),
                // SignUp(),
              ],
            ),
          ),
        ],
      ),
    )
    );
  }
  }
