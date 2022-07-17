import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class PastExcercise {
  final String name;
  final double calories;
  final String date;

  PastExcercise(this.name, this.calories, this.date);
}

class FetchPreviousExcercise extends ChangeNotifier {
  List<PastExcercise> pastExcercise = [];

  fetchPreviousExcercise() async {
    pastExcercise = [];
    final uuid = FirebaseAuth.instance.currentUser?.uid;
    final ffirestore = await FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .collection('past_exercises')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        final data = element.data();
        final name = data['name'];
        final calories = data['calories'];
        dynamic date =
            DateFormat.yMEd().add_jms().format(DateTime.parse(data['date']));

        print(date);

        final pastExcercise = PastExcercise(name, calories, date);
        this.pastExcercise.add(pastExcercise);
      });
    });
    notifyListeners();
  }
}
