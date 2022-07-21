import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user-attributes-provider.dart';

class BMIWidget extends StatefulWidget {
  @override
  State<BMIWidget> createState() => _BMIWidgetState();
}

class _BMIWidgetState extends State<BMIWidget> {
  double? height, weight;
  double? _bmi;
  String? _bmiCategory;
  bool firstTime = false;

  @override
  Future<void> didChangeDependencies() async {
    await Provider.of<UserAttributesProvider>(
      context,
      listen: firstTime,
    ).fetchUserAttributes();

    weight = Provider.of<UserAttributesProvider>(context, listen: false).weight;
    height = Provider.of<UserAttributesProvider>(context, listen: false).height;

    _bmi = weight! / pow(height! / 100, 2);
    if (_bmi! >= 25) {
      _bmiCategory = 'Overweight';
    } else if (_bmi! > 18.5) {
      _bmiCategory = 'Healthy';
    } else {
      _bmiCategory = "underweight";
    }
    //
    // print("Printing age, weight, height: $age, $weight, $height");
    // print("age is >>>>>>>>>> $age");
    // print("weight is >>>>>>>>>> $weight");
    // print("height is >>>>>>>>>> $height");

    if (weight != null && height != null) {
      {
        setState(() {
          firstTime = false;
        });
      }
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: FittedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'BMI',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${_bmi?.toStringAsFixed(1)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${_bmiCategory}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                // color: Theme.of(context).colorScheme.secondary
              ),
            ),
          ],
        ),
      ),
    );
  }
}
