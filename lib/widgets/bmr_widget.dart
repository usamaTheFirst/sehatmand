import 'dart:math';

import 'package:flutter/material.dart';

class BMRWidget extends StatefulWidget {
  BMRWidget(
      {Key? key,
      required this.height,
      required this.weight,
      required this.age}) {
    _bmi = weight / pow(height / 100, 2);
    if (_bmi >= 25) {
      _bmiCategory = 'Overweight';
    } else if (_bmi > 18.5) {
      _bmiCategory = 'Healthy';
    } else {
      _bmiCategory = "underweight";
    }
  }

  final double height, weight, age;
  late final double _bmi;
  late final String _bmiCategory;

  @override
  State<BMRWidget> createState() => _BMRWidgetState();
}

class _BMRWidgetState extends State<BMRWidget> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'BMR',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            // '${widget._bmi.toStringAsFixed(1)}',
            "67.4",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${widget._bmiCategory}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              // color: Theme.of(context).colorScheme.secondary
            ),
          ),
        ],
      ),
    );
  }
}
