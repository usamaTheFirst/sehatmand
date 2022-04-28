import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class footCounter extends StatefulWidget {
  const footCounter({Key? key}) : super(key: key);

  @override
  _footCounterState createState() => _footCounterState();
}

class _footCounterState extends State<footCounter> {
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;
  int steps = 0;
  double exactDistance = 0.0;
  double previousDistance = 0.0;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 200,
        alignment: Alignment.center,
        child: StreamBuilder<AccelerometerEvent>(
          stream: SensorsPlatform.instance.accelerometerEvents,
          builder: (context, snapshort) {
            if (snapshort.hasData) {
              x = snapshort.data!.x;
              y = snapshort.data!.y;
              z = snapshort.data!.z;
              exactDistance = calculateMagnitude(x, y, z);
              if (exactDistance > 6) {
                steps++;
              }
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  FontAwesomeIcons.walking,
                  size: 60,
                ),
                Text(
                  steps.toString(),
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            );
          },
        ));
  }

  double calculateMagnitude(double x, double y, double z) {
    double distance = sqrt(x * x + y * y + z * z);
    getPreviousValue();
    double mode = distance - previousDistance;
    setprefData(distance);
    return mode;
  }

  void setprefData(double predistance) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setDouble("previousDistance", predistance);
  }

  void getPreviousValue() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      previousDistance = _pref.getDouble("previousDistance") ?? 0;
    });
  }
}
