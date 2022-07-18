import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
                        onPressed: () {},
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
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BMIWidget(
                        height: 170,
                        weight: 70,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BMRWidget(
                        height: 170,
                        weight: 70,
                        age: 12,
                      ),
                    ],
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
              child: ListView(
                children: [
                  ExerciseWidget(
                    title: "Running",
                    image:
                        "https://images.everydayhealth.com/images/how-to-start-working-out-again-derailed-from-covid-1440x810.jpg",
                    description:
                        'Running is a method of terrestrial locomotion allowing humans and other animals to move rapidly on foot. Running is a type of gait characterized by an aerial phase in which all feet are above the ground (though there are exceptions)',
                    calories: 100,
                  ),
                  ExerciseWidget(
                    title: "Running",
                    image:
                        "https://images.everydayhealth.com/images/how-to-start-working-out-again-derailed-from-covid-1440x810.jpg",
                    description:
                        'Running is a method of terrestrial locomotion allowing humans and other animals to move rapidly on foot. Running is a type of gait characterized by an aerial phase in which all feet are above the ground (though there are exceptions)',
                    calories: 100,
                  ),
                  ExerciseWidget(
                    title: "Running",
                    image:
                        "https://images.everydayhealth.com/images/how-to-start-working-out-again-derailed-from-covid-1440x810.jpg",
                    description:
                        'Running is a method of terrestrial locomotion allowing humans and other animals to move rapidly on foot. Running is a type of gait characterized by an aerial phase in which all feet are above the ground (though there are exceptions)',
                    calories: 100,
                  ),
                  ExerciseWidget(
                    title: "Running",
                    image:
                        "https://images.everydayhealth.com/images/how-to-start-working-out-again-derailed-from-covid-1440x810.jpg",
                    description:
                        'Running is a method of terrestrial locomotion allowing humans and other animals to move rapidly on foot. Running is a type of gait characterized by an aerial phase in which all feet are above the ground (though there are exceptions)',
                    calories: 100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
