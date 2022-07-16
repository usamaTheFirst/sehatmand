import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sehatmand/widgets/bmi_widget.dart';
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
      body: Column(
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
                    BMIWidget(
                      height: 170,
                      weight: 70,
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
                      'lorem fdfdggggggggggggggggggggggd gd ge g dg d gd gd g d gd gd gd g d gd gd gd gd gd g d g',
                  calories: 100,
                ),
                ExerciseWidget(
                  title: "Running",
                  image:
                      "https://images.everydayhealth.com/images/how-to-start-working-out-again-derailed-from-covid-1440x810.jpg",
                  description:
                      'lorem fdfdggggggggggggggggggggggd gd ge g dg d gd gd g d gd gd gd g d gd gd gd gd gd g d g',
                  calories: 100,
                ),
                ExerciseWidget(
                  title: "Running",
                  image:
                      "https://images.everydayhealth.com/images/how-to-start-working-out-again-derailed-from-covid-1440x810.jpg",
                  description:
                      'lorem fdfdggggggggggggggggggggggd gd ge g dg d gd gd g d gd gd gd g d gd gd gd gd gd g d g',
                  calories: 100,
                ),
                ExerciseWidget(
                  title: "Running",
                  image:
                      "https://images.everydayhealth.com/images/how-to-start-working-out-again-derailed-from-covid-1440x810.jpg",
                  description:
                      'lorem fdfdggggggggggggggggggggggd gd ge g dg d gd gd g d gd gd gd g d gd gd gd gd gd g d g',
                  calories: 100,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
