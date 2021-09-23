import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_chat/consts.dart';
import 'package:firebase_chat/providers/chat.dart';
import 'package:firebase_chat/screens/calls_screen/calls_screen.dart';
import 'package:firebase_chat/screens/chats_screen/all_chats_screen.dart';
import 'package:firebase_chat/screens/profile_screen/profile_info.dart';
import 'package:firebase_chat/services/db.dart';
import 'contacts_screen/contacts_screen.dart';
import 'package:connectivity/connectivity.dart';



class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}
 Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

class _HomeState extends State<Home> with SingleTickerProviderStateMixin, 
  WidgetsBindingObserver  {
  TabController tabController;
  DB db;
  bool isLoading = true;
  bool initLoaded = true;  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    db = DB();        
    // Fetch user data(chats and contacts), and update online status
    Future.delayed(Duration.zero).then((value) {         
        Provider.of<Chat>(context, listen: false).getUserDetailsAndContacts().then((value) {
          if(value)
          Provider.of<Chat>(context, listen: false).fetchChats();
          check().then((intenet) {
         if (intenet != null && intenet) {
         _updateOnlineStatus(true);   
        // Internet Present Case
         }
      // No-Internet Case
    });
                
    }
     );        
      }).then((value) => setState(() => initLoaded = true)
      //);    
  );}


     


  







  @override
  void didChangeDependencies() {   
    if(initLoaded)
    {
      initLoaded= false;
      isLoading = false;
    }
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {  
    if(state == AppLifecycleState.paused)  _updateOnlineStatus(false);
    else if(state == AppLifecycleState.resumed) _updateOnlineStatus(true);
    // else if(state == AppLifecycleState.detached) _updateOnlineStatus(false);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Update user status on Firebase
  Future<dynamic> _updateOnlineStatus(bool status) {
    final uid = Provider.of<Chat>(context, listen: false).getUserId;
    final docRef = Firestore.instance.collection(USERS_COLLECTION).document(uid);
    return Firestore.instance.runTransaction((transaction) async {      
      await transaction.update(docRef, {
        'isOnline': status,
      });
    });
  }

  Widget _buildTabs() {
    return Container(
      color:kBaseWhiteColor,      
      child: Tabs(tabController),
    );
  }

  Widget _buildTabContent() {
    return TabBarView(
      controller: tabController,
      children: [
        AllChatsScreen(),
        ContactsScreen(),
        CallsScreen(),
        ProfileInfo(),
      ],
    );
  }  

  @override
  Widget build(BuildContext context) {        
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body:_buildTabContent(),
        bottomNavigationBar: _buildTabs(),        
      ),
    );
  }
}

class Tabs extends StatefulWidget {
  final TabController tabController;
  Tabs(this.tabController);
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
    widget.tabController.index = index;
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color:Colors.grey
    );

    BottomNavigationBarItem _buildTabBarItem(String label, IconData icon, IconData activeIcon) {
      return BottomNavigationBarItem(
        
        
        icon: Icon(icon,color: Colors.grey,),
        activeIcon: Icon(activeIcon, size: 35,color: kPrimaryColor,),
        title:
           Text(label,style: TextStyle(color:  Colors.grey,),),
      
      );
    }

    return CupertinoTabBar(
      items: [
        _buildTabBarItem('Chats', CupertinoIcons.chat_bubble, CupertinoIcons.chat_bubble,),
        _buildTabBarItem('People', (Icons.people), (Icons.people)),
        _buildTabBarItem('Calls', CupertinoIcons.phone,CupertinoIcons.phone_solid),
        _buildTabBarItem('profile', CupertinoIcons.person, CupertinoIcons.person_solid),
        //  BottomNavigationBarItem(icon: Icon(Icons.messenger), label: 'Chats'),
        //   BottomNavigationBarItem(icon: Icon(Icons.people), label: 'People'),
        //   BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Calls'),
        //   BottomNavigationBarItem(
        //       icon: CircleAvatar(
        //         radius: 14,
        //         backgroundImage: AssetImage('assets/images/user_2.png'),
        //       ),
        //       label: 'profile'),
      ],
      onTap: onTap,
      currentIndex: currentIndex,
      activeColor: Theme.of(context).accentColor,
      inactiveColor: Colors.white.withOpacity(0.7),
      backgroundColor: kBaseWhiteColor,
      
    );
  }
}
