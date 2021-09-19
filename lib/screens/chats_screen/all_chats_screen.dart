import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_chat/components/filled_outlined_button.dart';
import 'package:firebase_chat/consts.dart';
import 'package:firebase_chat/models/chat_data.dart';
import 'package:firebase_chat/providers/chat.dart';
import 'package:firebase_chat/screens/chats_screen/widgets/chats_list_item.dart';
import 'package:firebase_chat/services/db.dart';
import 'package:firebase_chat/widgets/body_list.dart';

class AllChatsScreen extends StatefulWidget {
  @override
  _AllChatsScreenState createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen>
    with AutomaticKeepAliveClientMixin {
  DB db = DB();

  Widget  _buildChats(List<ChatData> chats) => BodyList(
        child: ListView.separated(
          padding: const EdgeInsets.only(top: 10),
          itemCount: chats.length,
          itemBuilder: (ctx, i) => ChatListItem(chatData: chats[i]),
          separatorBuilder: (ctx, i) {
            return Divider(
              indent: 0,
              endIndent: 15,
              height: 0,
              thickness: 1,
              color: Colors.grey.withOpacity(0.1),
            );
          },
        ),
      );

  Widget _buildEmptyIndicator() => Center(
        child: Text(
          'You have no messages yet.',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kBaseWhiteColor,
          ),
        ),
      );

  void updateChats(BuildContext context, AsyncSnapshot<dynamic> snapshots) {
    if (snapshots != null && snapshots.data != null) {
      final currContacts =
          Provider.of<Chat>(context, listen: false).getContacts;
      final currContactLength = currContacts.length;
      final contacts = snapshots.data['contacts'];
      if (contacts != null) if (contacts.length > currContactLength) {
        Provider.of<Chat>(context, listen: false)
            .handleMessagesNotFromContacts(contacts);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final chats = Provider.of<Chat>(context).chats;
    final isLoading = Provider.of<Chat>(context).isLoading;
    final uid = Provider.of<Chat>(context).getUserId;    
    return Scaffold(
         appBar: buildAppBar(),
      body: StreamBuilder(
        stream: db.getUserContactsStream(uid),
        builder: (ctx, snapshots) {
          if (!isLoading && snapshots.hasData) updateChats(context, snapshots);
        
          return Column(
            children: [
              
           Container(
            padding: EdgeInsets.fromLTRB(
                kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
            color: kPrimaryColor,
            child: Row(
              children: [
                FillOutlineButton(press: () {}, text: 'Recent Messages'),
                SizedBox(width: kDefaultPadding),
                FillOutlineButton(
                  press: () {},
                  text: 'Active',
                  isFilled: false,
                ),
              ],
            ),
          ),
              // Container(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       TabScreenTitle(
              //         title: 'Chats',
              //         actionWidget: CupertinoButton(
              //           padding: const EdgeInsets.all(0),
              //           onPressed: () {},
              //           child: Container(
              //             padding: const EdgeInsets.all(5),
              //             child: Icon(Icons.add, color: Colors.white, size: 25),
              //             decoration: BoxDecoration(
              //               color: kBaseWhiteColor,
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //           ),
              //         ),
              //       ),
              //       // SizedBox(height: 15),
              //       // Stories(),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 10),
              // Divider(
              //   color: kBorderColor3,
              //   height: 0,
              // ),
              isLoading
                  ? Center(child: CupertinoActivityIndicator())
                  : chats.isEmpty ? _buildEmptyIndicator() : _buildChats(chats),
            ],
          );
        },
      ),
    );
  }
 AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text('Chats'),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }
  @override
  bool get wantKeepAlive => true;
}
