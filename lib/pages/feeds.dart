import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sehatmand/chats/recent_chats.dart';
import 'package:sehatmand/models/post.dart';
import 'package:sehatmand/utils/firebase.dart';
import 'package:sehatmand/widgets/indicators.dart';
import 'package:sehatmand/widgets/userpost.dart';
import 'package:sehatmand/components/fab_container.dart';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<DocumentSnapshot> post = [];

  bool isLoading = false;

  bool hasMore = true;

  int documentLimit = 10;

  DocumentSnapshot? lastDocument;

  ScrollController? _scrollController;

  getPosts() async {
    print("get posts called");
    if (!hasMore) {
      print('No New Posts');
    }
    if (isLoading) {
      return CircularProgressIndicator();
    }
    setState(() {
      isLoading = true;
    });
    // print("######### $lastDocument");
    QuerySnapshot querySnapshot;
    if (lastDocument == null) {
      querySnapshot = await postRef
          .orderBy('timestamp', descending: false)
          .limit(documentLimit)
          .get();
    } else {
      querySnapshot = await postRef
          .orderBy('timestamp', descending: false)
          .startAfterDocument(lastDocument!)
          .limit(documentLimit)
          .get();
    }
    if (querySnapshot.docs.length < documentLimit) {
      hasMore = false;
    }
    lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    post.addAll(querySnapshot.docs);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getPosts();
    _scrollController?.addListener(() {
      double maxScroll = _scrollController!.position.maxScrollExtent;
      double currentScroll = _scrollController!.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;
      if (maxScroll - currentScroll <= delta) {
        getPosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Sehatmand',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        // actions: [
          // IconButton(
          //   icon: Icon(
          //     CupertinoIcons.chat_bubble_2_fill,
          //     size: 30.0,
          //     color: Theme.of(context).accentColor,
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       CupertinoPageRoute(
          //         builder: (_) => Chats(),
          //       ),
          //     );
          //   },
          // ),
          // SizedBox(width: 20.0),
        // ],
      ),
      body: isLoading
          ? circularProgress(context)
          : ListView.builder(
              controller: _scrollController,
              itemCount: post.length,
              itemBuilder: (context, index) {
                internetChecker(context);
                //TODO: I commented this old
                PostModel posts = PostModel.fromJson(post[index].data() as Map<String, dynamic>);
                // PostModel posts = PostModel.fromJson(json.decode(post[index].data().toString()));
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: UserPost(post: posts),
                );
              },
            ),
      floatingActionButton: new FabContainer(page: Text("nes"), icon:  CupertinoIcons.add),
    );
  }

  internetChecker(context) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == false) {
      showInSnackBar('No Internet Connection', context);
    }
  }

  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
