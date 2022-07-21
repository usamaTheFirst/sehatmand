import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/event.dart';
import '../utils/firebase.dart';

class InvitationCard extends StatelessWidget {
  final EventModel event;

  const InvitationCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 40,
              child: Text(
                '${event.username} Invited you for a workout',
                style: TextStyle(
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () async {
                    DocumentSnapshot? doc = await usersRef
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get();
                    accept(
                    uid: event.userId,
                    name: doc.get('username'),
                    photoUrl: doc.get('photoUrl')
                  );
              },
                  child: Text('Accept', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () {decline(event.userId);},
                  child: Text('Decline', style: TextStyle(color: Colors.white)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  decline(uid) async {
    eventRef
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('events')
        .doc(uid)
        .get()
        .then((doc) => {
            if (doc.exists) {
                doc.reference.delete(),
            }
        });
  }

  accept({uid, name, photoUrl}) async {
    notificationRef
        .doc(uid)
        .collection('notifications')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "type": "eventAcc",
      "ownerId": uid,
      "username": name,
      "userId": FirebaseAuth.instance.currentUser!.uid,
      "userDp": photoUrl,
      "timestamp": DateTime.now(),
    });
    decline(uid);
  }
}
