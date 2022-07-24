import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sehatmand/models/exercises-list.dart';
import 'package:sehatmand/models/food.dart';
import 'package:sehatmand/widgets/bmi_widget.dart';
import 'package:sehatmand/widgets/bmr_widget.dart';
// import 'package:sehatmand/widgets/exercise_widget.dart';
import 'package:sehatmand/widgets/foot_counter.dart';
import 'package:sehatmand/widgets/points_widget.dart';

import '../widgets/calorie_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var idx = 0;
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: 300,
                  color: Theme.of(context).backgroundColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "What did you eat?",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 200,
                        color: Colors.grey,
                        child: CupertinoPicker(
                          useMagnifier: true,
                          backgroundColor: Colors.white,
                          itemExtent: 50,
                          onSelectedItemChanged: (index) {
                            // print(index);
                            setState(() {
                              idx = index;
                            });
                          },
                          children: [
                            ...food_list.map((e) {
                              return Text("${e.name} - ${e.calories}cal");
                            }).toList()
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print(idx);
                          print(food_list[idx].name);
                          print(food_list[idx].calories);

                          Navigator.of(context).pop();

                          var id = FirebaseAuth.instance.currentUser?.uid;
                          FirebaseFirestore.instance
                              .collection('calorie_tracker')
                              .doc(id)
                              .update({
                            "calories":
                                FieldValue.increment(food_list[idx].calories)
                          });
                        },
                        child: Text("Done"),
                      ),
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: 40,
              color: Colors.deepPurpleAccent,
              child: PointsWidget(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              height: 230,
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CalorieWidget(),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: BMIWidget(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(child: BMRWidget()),
                      ],
                    ),
                  ),
                  footCounter(),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return exercises_list[index];
                },
                itemCount: exercises_list.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Colors.grey,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
