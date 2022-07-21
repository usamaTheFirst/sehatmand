import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sehatmand/components/fab_container.dart';
import 'package:sehatmand/pages/notification.dart';
import 'package:sehatmand/pages/profile.dart';
import 'package:sehatmand/pages/search.dart';
import 'package:sehatmand/pages/feeds.dart';
import 'package:sehatmand/chats/recent_chats.dart';
import '../pages/events.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _page = 0;

  List pages = [
    {
      'title': 'Home',
      'icon': Icons.home,
      'page': Timeline(),
      'index': 0,
    },
    {
      'title': 'Search',
      'icon': Icons.search,
      'page': Search(),
      'index': 1,
    },
    {
      'title': 'Profile',
      'icon': CupertinoIcons.chat_bubble_2,
      'page': Chats(),
      'index': 2,
    },
    {
      'title': 'Events',
      'icon': Icons.event,
      'page': Events(),
      'index': 3,
    },
    {
      'title': 'Notification',
      'icon': Icons.notifications,
      'page': Activities(),
      'index': 4,
    },
    {
      'title': 'Profile',
      'icon': CupertinoIcons.person,
      'page': Profile(profileId: FirebaseAuth.instance.currentUser!.uid),
      'index': 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: [
              Tab(icon: Icon(pages[0]['icon']),),
              Tab(icon: Icon(pages[1]['icon']),),
              Tab(icon: Icon(pages[2]['icon']),),
              Tab(icon: Icon(pages[3]['icon']),),
              Tab(icon: Icon(pages[4]['icon']),),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            pages[0]['page'],
            pages[1]['page'],
            // buildFab(),
            // FabContainer(page: pages[2]['page'], icon: Icons.add_circle),
            pages[2]['page'],
            pages[3]['page'],
            pages[4]['page'],
          ],
        ),
        // body: PageTransitionSwitcher(
        //   transitionBuilder: (
        //     Widget child,
        //     Animation<double> animation,
        //     Animation<double> secondaryAnimation,
        //   ) {
        //     return FadeThroughTransition(
        //       animation: animation,
        //       secondaryAnimation: secondaryAnimation,
        //       child: child,
        //     );
        //   },
        //   child: pages[_page]['page'],
        // ),
        // bottomNavigationBar: BottomAppBar(
        //   child: Row(
        //     mainAxisSize: MainAxisSize.max,
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       SizedBox(width: 5),
        //       for (Map item in pages)
        //         item['index'] == 2
        //             ? buildFab()
        //             : Padding(
        //                 padding: const EdgeInsets.only(top: 5.0),
        //                 child: IconButton(
        //                   icon: Icon(
        //                     item['icon'],
        //                     color: item['index'] != _page
        //                         ? Colors.grey
        //                         : Theme.of(context).accentColor,
        //                     size: 20.0,
        //                   ),
        //                   onPressed: () => navigationTapped(item['index']),
        //                 ),
        //               ),
        //       SizedBox(width: 5),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  buildFab() {
    print(_page);
    return Container(
      height: 45.0,
      width: 45.0,
      // ignore: missing_required_param
      child: FabContainer(
        page: pages[_page]['page'],
        icon: Icons.add_circle,
        mini: true,
      ),
    );
  }

  void navigationTapped(int page) {
    setState(() {
      _page = page;
    });
  }
}
