import 'package:flutter/material.dart';

import '../../../consts.dart';

class BubbleText extends StatelessWidget {
   final bool isMe;
  const BubbleText({
    
    Key key,
    @required this.text,
      @required this.isMe,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SelectableText(
        text,
        style: TextStyle(
          fontSize: 17,
          color: isMe?kBaseWhiteColor:kBlackColor,
        ),
      ),
    );
  }
}
