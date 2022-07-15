import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseWidget extends StatelessWidget {
  const ExerciseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "https://images.everydayhealth.com/images/how-to-start-working-out-again-derailed-from-covid-1440x810.jpg",
              height: 150,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Running",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                SizedBox(height: 10),
                const Text(
                  "Running, or jogging, is one of the best cardio exercises you can do. Running for at least 10 minutes a day can significantly lower your risk of cardiovascular disease. Runners lower their chances of dying from heart disease by half",
                  style: TextStyle(fontSize: 13, color: Colors.green),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
