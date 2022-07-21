import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sehatmand/utils/firebase.dart';
import 'package:sehatmand/widgets/invite_exercise_card.dart';
import '../components/event_stream_wrapper.dart';
import '../models/event.dart';
import '../models/user.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final DateTime timestamp = DateTime.now();
  late UserModel user;

  currentUserId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Event invites'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () => deleteAllItems(),
              child: Text(
                'CLEAR',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          getEvents(),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     addEvent();
      //   },
      //   child: Icon(Icons.add),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  deleteAllItems() async {
//delete all notifications associated with the authenticated user
    QuerySnapshot notificationsSnap = await eventRef
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('event')
        .get();
    notificationsSnap.docs.forEach(
      (doc) {
        if (doc.exists) {
          doc.reference.delete();
        }
      },
    );
  }

  // addEvent() async {
  //   DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
  //   user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
  //   eventRef
  //       .doc(currentUserId())
  //       .set({
  //     "ownerId": user.id,
  //     "username": user.username,
  //     "timestamp": timestamp,
  //   });
  // }

  getEvents() {
    return EventStreamWrapper(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      stream: eventRef
          .doc(currentUserId())
          .collection('events')
          .orderBy('timestamp', descending: true)
          .limit(20)
          .snapshots(),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, DocumentSnapshot snapshot) {
        EventModel events =
        EventModel.fromJson(snapshot.data() as Map<String, dynamic>);
        return InvitationCard(
          event: events,
        );
      },
    );
  }

}
