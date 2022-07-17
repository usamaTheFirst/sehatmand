import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseWidget extends StatelessWidget {
  ExerciseWidget(
      {Key? key,
      required this.title,
      required this.description,
      required this.image,
      required this.calories})
      : super(key: key);
  bool done = false;
  final String title;
  final String description;
  final String image;
  final double calories;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              image,
              height: 150,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          final store = FirebaseFirestore.instance;
                          final uuid = FirebaseAuth.instance.currentUser?.uid;
                          store
                              .collection('users')
                              .doc(uuid)
                              .collection('past_exercises')
                              .add({
                            'name': title,
                            'date': DateTime.now().toIso8601String(),
                            'calories': calories,
                          });
                        },
                        child: const Text("Done")),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(fontSize: 13, color: Colors.green),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}