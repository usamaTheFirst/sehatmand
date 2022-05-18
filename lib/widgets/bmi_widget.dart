import 'dart:math';

import 'package:flutter/material.dart';

class BMIWidget extends StatelessWidget {
  BMIWidget({Key? key, required this.height, required this.weight}) {
    _bmi = weight / pow(height / 100, 2);
    if (_bmi >= 25) {
      _bmiCategory = 'Overweight';
    } else if (_bmi > 18.5) {
      _bmiCategory = 'Healthy.';
    } else {
      _bmiCategory = "underweight";
    }
  }

  final double height, weight;
  late final double _bmi;
  late final String _bmiCategory;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'BMI',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary),
          ),
          Text(
            '${_bmi.toStringAsFixed(1)}',
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary),
          ),
          Text(
            '$_bmiCategory',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
    );
  }
}
