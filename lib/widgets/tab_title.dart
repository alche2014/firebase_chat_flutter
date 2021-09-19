import 'package:flutter/material.dart';
import 'package:firebase_chat/consts.dart';

class TabScreenTitle extends StatelessWidget {
  final String title;
  final Widget actionWidget;
  final double height;
  final Function onTap;
  TabScreenTitle({this.title, this.actionWidget, this.onTap, this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ??80,
      color:kPrimaryColor,
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          if (actionWidget != null) actionWidget,
        ],
      ),
    );
  }
}
