import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:sehatmand/components/stream_grid_wrapper.dart';
import 'package:sehatmand/main.dart';
import 'package:sehatmand/models/post.dart';
import 'package:sehatmand/models/user.dart';
import 'package:sehatmand/screens/auth-screen.dart';
import 'package:sehatmand/screens/edit_profile.dart';
import 'package:sehatmand/screens/settings.dart';
import 'package:sehatmand/utils/firebase.dart';
import 'package:sehatmand/widgets/post_tiles.dart';
import 'package:sehatmand/widgets/posts_view.dart';

class Profile extends StatefulWidget {
  final profileId;

  Profile({this.profileId});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User user;
  bool isLoading = false;
  int postCount = 0;
  int followersCount = 0;
  int followingCount = 0;
  bool isToggle = true;
  bool isFollowing = false;
  bool isInvited = false;
  late UserModel users;
  final DateTime timestamp = DateTime.now();
  ScrollController controller = ScrollController();

  currentUserId() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  void initState() {
    super.initState();
    checkIfFollowing();
    alreadyInvited();
  }

  checkIfFollowing() async {
    DocumentSnapshot doc = await followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(currentUserId())
        .get();
    setState(() {
      isFollowing = doc.exists;
    });
  }

  alreadyInvited() async {
    DocumentSnapshot doc = await eventRef
        .doc(widget.profileId)
        .collection('events')
        .doc(currentUserId())
        .get();
    setState(() {
      isInvited = doc.exists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Your Profile'),
        actions: [
          widget.profileId == FirebaseAuth.instance.currentUser!.uid
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: GestureDetector(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Rerouter.routeName, (route) => false);
                      },
                      child: const Text(
                        'Log Out',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 15.0),
                      ),
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            floating: false,
            toolbarHeight: 5.0,
            collapsedHeight: 6.0,
            expandedHeight: 220.0,
            flexibleSpace: FlexibleSpaceBar(
              background: StreamBuilder(
                stream: usersRef.doc(widget.profileId).snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    UserModel user = UserModel.fromJson(
                        snapshot.data?.data() as Map<String?, dynamic>);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(user.photoUrl as String),
                                radius: 40.0,
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 32.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Visibility(
                                      visible: false,
                                      child: SizedBox(width: 10.0),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 130.0,
                                          child: Text(
                                            user.username as String,
                                            style: const TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w900),
                                            maxLines: null,
                                          ),
                                        ),
                                        const SizedBox(width: 13.0),
                                        Text(
                                          user.email,
                                          style: const TextStyle(
                                            // color: Color(0xff4D4D4D),
                                            fontSize: 10.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 10.0),
                                    widget.profileId == currentUserId()
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                CupertinoPageRoute(
                                                  builder: (_) => Setting(),
                                                ),
                                              );
                                            },
                                            child: Column(
                                              children: [
                                                Icon(Feather.settings,
                                                    color: Theme.of(context)
                                                        .accentColor),
                                                const Text(
                                                  'settings',
                                                  style:
                                                      TextStyle(fontSize: 11.5),
                                                )
                                              ],
                                            ),
                                          )
                                        : buildLikeButton(),
                                    // SizedBox(width: 10.0),
                                    // getRank()
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                          child: user.bio!.isEmpty
                              ? Container()
                              : Container(
                                  width: 200,
                                  child: Text(
                                    user.bio as String,
                                    style: const TextStyle(
                                      //    color: Color(0xff4D4D4D),
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: null,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          height: 50.0,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                StreamBuilder(
                                  stream: postRef
                                      .where('ownerId',
                                          isEqualTo: widget.profileId)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      QuerySnapshot? snap = snapshot.data;
                                      List<DocumentSnapshot> docs = snap!.docs;
                                      return buildCount(
                                          "POSTS", docs.length ?? 0);
                                    } else {
                                      return buildCount("POSTS", 0);
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Container(
                                    height: 50.0,
                                    width: 0.3,
                                    color: Colors.grey,
                                  ),
                                ),
                                StreamBuilder(
                                  stream: followersRef
                                      .doc(widget.profileId)
                                      .collection('userFollowers')
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      QuerySnapshot? snap = snapshot.data;
                                      List<DocumentSnapshot> docs = snap!.docs;
                                      return buildCount(
                                          "FOLLOWERS", docs?.length ?? 0);
                                    } else {
                                      return buildCount("FOLLOWERS", 0);
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Container(
                                    height: 50.0,
                                    width: 0.3,
                                    color: Colors.grey,
                                  ),
                                ),
                                StreamBuilder(
                                  stream: followingRef
                                      .doc(widget.profileId)
                                      .collection('userFollowing')
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      QuerySnapshot? snap = snapshot.data;
                                      List<DocumentSnapshot> docs = snap!.docs;
                                      return buildCount(
                                          "FOLLOWING", docs?.length ?? 0);
                                    } else {
                                      return buildCount("FOLLOWING", 0);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [buildProfileButton(user), getRank()],
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index > 0) return null;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Text(
                            'All Posts',
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                          // Spacer(),
                          SizedBox(
                            height: 40,
                          )
                          // buildIcons(),
                        ],
                      ),
                    ),
                    buildGridPost(),
                  ],
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: buildFAB(),
    );
  }

//show the toggling icons "grid" or "list" view.
  buildIcons() {
    if (isToggle) {
      return IconButton(
          icon: Icon(Feather.list),
          onPressed: () {
            setState(() {
              isToggle = false;
            });
          });
    } else if (isToggle == false) {
      return IconButton(
        icon: Icon(Icons.grid_on),
        onPressed: () {
          setState(() {
            isToggle = true;
          });
        },
      );
    }
  }

  getRank() {
    return Container(
      height: 40,
      width: 100,
      alignment: Alignment.center,
      // padding: EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple,
            Colors.pinkAccent,
          ],
        ),
      ),
      child: StreamBuilder(
        stream: pointsRef.doc(widget.profileId).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            var rank = snapshot.data?.get('points').floor() ~/ 100;
            return Text(
              "Rank: $rank",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            );
          } else {
            return Text(
              '0',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            );
          }
        },
      ),
    );
  }

  buildCount(String label, int count) {
    return Column(
      children: <Widget>[
        Text(
          count.toString(),
          style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w900,
              fontFamily: 'Ubuntu-Regular'),
        ),
        const SizedBox(height: 3.0),
        Text(
          label,
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: 'Ubuntu-Regular'),
        )
      ],
    );
  }

  buildProfileButton(user) {
    //if isMe then display "edit profile"
    bool isMe = widget.profileId == FirebaseAuth.instance.currentUser!.uid;
    if (isMe) {
      return buildButton(
          text: "Edit Profile",
          function: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (_) => EditProfile(
                  user: user,
                ),
              ),
            );
          });
      //if you are already following the user then "unfollow"
    } else if (isFollowing) {
      return buildButton(
        text: "Unfollow",
        function: handleUnfollow,
      );
      //if you are not following the user then "follow"
    } else if (!isFollowing) {
      return buildButton(
        text: "Follow",
        function: handleFollow,
      );
    }
  }

  buildButton({required String text, required Function function}) {
    return Center(
      child: GestureDetector(
        onTap: function as void Function()?,
        child: Container(
          height: 40.0,
          width: 150.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).accentColor,
                Color(0xff597FDB),
              ],
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  handleUnfollow() async {
    DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
    users = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    setState(() {
      isFollowing = false;
    });
    //remove follower
    followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(currentUserId())
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    //remove following
    followingRef
        .doc(currentUserId())
        .collection('userFollowing')
        .doc(widget.profileId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    //remove from notifications feeds
    notificationRef
        .doc(widget.profileId)
        .collection('notifications')
        .doc(currentUserId())
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  handleFollow() async {
    DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
    users = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    setState(() {
      isFollowing = true;
    });
    //updates the followers collection of the followed user
    followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(currentUserId())
        .set({});
    //updates the following collection of the currentUser
    followingRef
        .doc(currentUserId())
        .collection('userFollowing')
        .doc(widget.profileId)
        .set({});
    //update the notification feeds
    notificationRef
        .doc(widget.profileId)
        .collection('notifications')
        .doc(currentUserId())
        .set({
      "type": "follow",
      "ownerId": widget.profileId,
      "username": users.username,
      "userId": users.id,
      "userDp": users.photoUrl,
      "timestamp": timestamp,
    });
  }

  // buildPostView() {
  //   if (isToggle == true) {
  //     return buildGridPost();
  //   } else if (isToggle == false) {
  //     return buildPosts();
  //   }
  // }

  // buildPosts() {
  //   return StreamBuilderWrapper(
  //     shrinkWrap: true,
  //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //     stream: postRef
  //         .where('ownerId', isEqualTo: widget.profileId)
  //         .orderBy('timestamp', descending: true)
  //         .snapshots(),
  //     physics: NeverScrollableScrollPhysics(),
  //     itemBuilder: (_, DocumentSnapshot snapshot) {
  //       PostModel posts =
  //           PostModel.fromJson(snapshot.data() as Map<String, dynamic>);
  //       return Padding(
  //         padding: const EdgeInsets.only(bottom: 15.0),
  //         child: Posts(
  //           post: posts,
  //         ),
  //       );
  //     },
  //   );
  // }

  buildGridPost() {
    return StreamGridWrapper(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      stream: postRef
          .where('ownerId', isEqualTo: widget.profileId)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, DocumentSnapshot snapshot) {
        PostModel posts =
            PostModel.fromJson(snapshot.data() as Map<String, dynamic>);
        return PostTile(
          post: posts,
        );
      },
    );
  }

  buildLikeButton() {
    return StreamBuilder(
      stream: favUsersRef
          .where('postId', isEqualTo: widget.profileId)
          .where('userId', isEqualTo: currentUserId())
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot> docs = snapshot?.data?.docs ?? [];
          return GestureDetector(
            onTap: () {
              if (docs.isEmpty) {
                favUsersRef.add({
                  'userId': currentUserId(),
                  'postId': widget.profileId,
                  'dateCreated': Timestamp.now(),
                });
              } else {
                favUsersRef.doc(docs[0].id).delete();
              }
            },
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 5.0,
                )
              ], color: Colors.white, shape: BoxShape.circle),
              child: Padding(
                padding: EdgeInsets.all(3.0),
                child: Icon(
                  docs.isEmpty
                      ? CupertinoIcons.heart
                      : CupertinoIcons.heart_fill,
                  color: Colors.red,
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  buildFAB() {
    bool isMe = widget.profileId == FirebaseAuth.instance.currentUser!.uid;
    if (!isMe) {
      return FloatingActionButton.extended(
        onPressed: () {
          manageEvent();
          setState(() {
            isInvited = !isInvited;
          });
          print("alreadyInvited(): $isInvited");
        },
        // child: Icon(Icons.add),
        label: isInvited ? Text('Already invited') : Text('Invite for workout'),
      );
    }
  }

  manageEvent() {
    isInvited ? deleteEvent() : addEvent();
  }

  addEvent() async {
    DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
    users = UserModel.fromJson(doc.data() as Map<String, dynamic>);

    //updates the events list for the user
    eventRef
        .doc(widget.profileId)
        .collection('events')
        .doc(currentUserId())
        .set({
      "ownerId": users.id,
      "username": users.username,
      "userDp": users.photoUrl,
      "timestamp": timestamp,
    });

    //send user notification
    notificationRef
        .doc(widget.profileId)
        .collection('notifications')
        .doc(currentUserId())
        .set({
      "type": "eventReq",
      "ownerId": widget.profileId,
      "username": users.username,
      "userId": users.id,
      "userDp": users.photoUrl,
      "timestamp": timestamp,
    });

    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Invited for event")));
  }

  deleteEvent() async {
    eventRef
        .doc(widget.profileId)
        .collection('events')
        .doc(currentUserId())
        .get()
        .then((doc) => {
              if (doc.exists)
                {
                  doc.reference.delete(),
                }
            });

    //delete notification
    notificationRef
        .doc(widget.profileId)
        .collection('notifications')
        .doc(currentUserId())
        .get()
        .then((doc) {
      if (doc.exists && doc.get('type') == "eventReq") {
        doc.reference.delete();
      }
    });
  }
}
