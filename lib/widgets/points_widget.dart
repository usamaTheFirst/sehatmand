import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PointsWidget extends StatefulWidget {
  const PointsWidget({Key? key}) : super(key: key);

  @override
  State<PointsWidget> createState() => _PointsWidgetState();
}

class _PointsWidgetState extends State<PointsWidget> {
  int xp = 0, rank = 1;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final uuid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore.instance
        .collection('points')
        .doc(uuid)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        var points = snapshot.data()!['points'].floor();
        xp = points % 100;

        rank = points ~/ 100;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LinearPercentIndicator(
          width: MediaQuery.of(context).size.width * 0.8,
          lineHeight: 20.0,
          percent: xp / 100,
          animation: true,
          barRadius: Radius.circular(10),

          center: Text(
            "${xp ?? 0} XP",
          ),
          backgroundColor: Color(0xFF222831),
          // progressColor: Colors.deepPurple,
          linearGradient: LinearGradient(
            colors: [
              Colors.red,
              Colors.green,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        Text(
          "Rank: ${rank ?? 1}",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
