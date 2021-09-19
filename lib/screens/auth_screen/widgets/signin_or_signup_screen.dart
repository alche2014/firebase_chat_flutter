import 'package:flutter/material.dart';
import 'package:firebase_chat/consts.dart';
import 'package:firebase_chat/screens/auth_screen/widgets/input_field.dart';
import 'package:firebase_chat/screens/auth_screen/widgets/signup.dart';



class SigninOrSignup extends StatefulWidget {
  @override
  _SigninOrSignupState createState() => _SigninOrSignupState();
}

class _SigninOrSignupState extends State<SigninOrSignup>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      color:
      
      Theme.of(context).scaffoldBackgroundColor,
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
            // backgroundColor: Colors.white,
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
                 SignupScreen()

              ],
            ),
          ),
        ],
      ),
    );
  }
}

