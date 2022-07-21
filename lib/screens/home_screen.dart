import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sehatmand/models/exercises-list.dart';
import 'package:sehatmand/widgets/bmi_widget.dart';
import 'package:sehatmand/widgets/bmr_widget.dart';
import 'package:sehatmand/widgets/exercise_widget.dart';
import 'package:sehatmand/widgets/foot_counter.dart';

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
                            print(index);
                          },
                          children: [
                            Text("Apple - 16cal"),
                            Text("Banana - 13cal"),
                            Text("Orange - 15cal"),
                            Text("Mango - 17cal"),
                            Text("Pineapple - 20cal"),
                            Text("Strawberry - 18cal"),
                            Text("Watermelon - 21cal"),
                            Text("Beef - 100cal"),
                            Text("Chicken - 80cal"),
                            Text("Mutton - 70cal"),
                            Text("Fish - 50cal"),
                            Text("Egg - 10cal"),
                            Text("Milk - 20cal"),
                            Text("Cheese - 30cal"),
                            Text("Yogurt - 40cal"),
                            Text("Rice - 50cal"),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
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
            // Container(
            //   decoration: BoxDecoration(
            //     border: Border(
            //       bottom: BorderSide(
            //         color: Colors.grey,
            //         width: 1,
            //       ),
            //     ),
            //   ),
            //   height: 120,
            //   padding: const EdgeInsets.symmetric(vertical: 15),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       BMIWidget(height: 170, weight: 70),
            //       BMIWidget(height: 170, weight: 70),
            //     ],
            //   ),
            // ),
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
