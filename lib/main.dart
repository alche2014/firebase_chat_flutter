import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/consts.dart';
import 'package:firebase_chat/providers/auth.dart';
import 'package:firebase_chat/providers/chat.dart';
import 'package:firebase_chat/screens/auth_screen/auth_screen.dart';
import 'package:firebase_chat/screens/home.dart';
import 'package:firebase_chat/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
void main() async {
   await DotEnv().load('.env');
   final Firestore firestore = Firestore();
  //firestore presistance initaization
   await firestore.settings(timestampsInSnapshotsEnabled: true);
   runApp(MyApp());
    }

  enum AuthMode {
  LOGGED_IN,
  LOGGED_OUT,
   } 

  class MyApp extends StatelessWidget {
  final future = Auth().getCurrentUser();


  @override
  Widget build(BuildContext context) {

    FlutterStatusbarcolor.setStatusBarColor(kPrimaryColor.withOpacity(0.1));
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProvider.value(value: Chat()),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
              theme: lightThemeData(context),
              darkTheme: darkThemeData(context),
           
              home: FutureBuilder(
              future: auth.getCurrentUser(),
              builder: (ctx, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CupertinoActivityIndicator())
                : snapshot.data == null ? AuthScreen(): Home();
              },
            ),
            debugShowCheckedModeBanner: false,
              ),
        ));
  }
}
