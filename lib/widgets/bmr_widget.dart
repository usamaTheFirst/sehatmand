import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user-attributes-provider.dart';

class BMRWidget extends StatefulWidget {
  BMRWidget({
    Key? key,
  });

  @override
  State<BMRWidget> createState() => _BMRWidgetState();
}

class _BMRWidgetState extends State<BMRWidget> {
  double? height, weight;
  int? age;
  double? _bmr;
  String? _bmiCategory;
  bool firstTime = false;

  @override
  Future<void> didChangeDependencies() async {
    await Provider.of<UserAttributesProvider>(
      context,
      listen: firstTime,
    ).fetchUserAttributes();

    age = Provider.of<UserAttributesProvider>(context, listen: false).age;
    weight = Provider.of<UserAttributesProvider>(context, listen: false).weight;
    height = Provider.of<UserAttributesProvider>(context, listen: false).height;

    print("Printing age, weight, height: $age, $weight, $height");
    print("age is >>>>>>>>>> $age");
    print("weight is >>>>>>>>>> $weight");
    print("height is >>>>>>>>>> $height");

    _bmr = 88.362 + (13.397 * weight!) + (4.799 * height!) - (5.677 * age!);

    _bmiCategory = "Calories\nrequired\n${(_bmr! * 1.375).toStringAsFixed(2)}";
    if (age != null && weight != null && height != null) {
      {
        setState(() {
          firstTime = false;
        });
      }
    }
    super.didChangeDependencies();
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //
  //   // print("Inside BMRWidget initState");
  //   // print('age: $age, weight: $weight, height: $height');
  //
  //   //BMR = 88.362 + (13.397 x weight in kg) + (4.799 x height in cm) – (5.677 x age in years)
  //
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    print("building BMR");
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        _bmiCategory.toString(),
        overflow: TextOverflow.visible,
        softWrap: true,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      // child: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: <Widget>[
      //     Text(
      //       'BMR',
      //       style: TextStyle(
      //         fontSize: 16,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //     Text(
      //       // '${widget._bmi.toStringAsFixed(1)}',
      //       "67.4",
      //       style: TextStyle(
      //         fontSize: 16,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //     Text(
      //       '${widget._bmiCategory}',
      //       style: TextStyle(
      //         fontSize: 16,
      //         fontWeight: FontWeight.bold,
      //         // color: Theme.of(context).colorScheme.secondary
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
