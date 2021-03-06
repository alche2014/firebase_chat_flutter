import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_chat/consts.dart';
import 'package:firebase_chat/screens/calls_screen/widgets/call.dart';
import 'package:firebase_chat/screens/chats_screen/widgets/avatar.dart';
import 'package:firebase_chat/widgets/overlay_utils.dart';

class CallItem extends StatelessWidget {
  final Function onTap;

  const CallItem({Key key, this.onTap}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        highlightColor: kBlackColor2,
        // splashColor: Colors.transparent,
        onTap: () => OverlayUtils.overlay(
          context: context,
          alignment: Alignment.topCenter,
          child: CallingScreen(),
          duration: Duration(seconds: 5),
        ),
        child: ListTile(
          leading: Avatar(imageUrl: myPic, radius: 20),
          title: Text('User'),
          subtitle: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(
                Icons.videocam,
                color: kBaseWhiteColor.withOpacity(0.5),
                size: 15,
              ),
              SizedBox(width: 5),
              Text(
                'Incoming',
                style: TextStyle(color: kBaseWhiteColor.withOpacity(0.5)),
              )
            ],
          ),
          trailing: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                DateFormat.Hm().format(DateTime.now()),
                style: TextStyle(color: kBaseWhiteColor.withOpacity(0.65)),
              ),
              SizedBox(width: 8),
              Icon(Icons.phone, color:kPrimaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
