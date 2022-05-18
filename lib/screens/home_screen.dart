import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sehatmand/widgets/bmi_widget.dart';
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
      appBar: AppBar(
        title: const Text('Home'),
      ),
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
            height: 200,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CalorieWidget(),
                footCounter(),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
            height: 200,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BMIWidget(height: 170, weight: 70),
                BMIWidget(height: 170, weight: 70),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}
