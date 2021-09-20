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
            print("object:::::::::::::${ chats[i].peerId}");
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
            color: kBlackColor,
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
          // if (!isLoading && snapshots.hasData) updateChats(context, snapshots);
        
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
              isLoading
                  ? Center(child: CupertinoActivityIndicator())
                  : chats.isEmpty ? Container(
                  height: MediaQuery.of(context).size.height/1.5,
                    child: _buildEmptyIndicator()) : _buildChats(chats),
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
