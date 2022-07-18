import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sehatmand/providers/excercise_provider.dart';

class PastExercisesScreen extends StatelessWidget {
  const PastExercisesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Want Some Diet Recommendation?",
                    style: TextStyle(fontSize: 20)),
                MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Diet Recommendation"),
                            content: Text(
                                "Protien: 1.5g\n\nCarbohydrates: 1.5g\n\nFat: 1.5g"),
                            actions: [
                              FlatButton(
                                child: Text("Close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    "Gain Weight",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  color: Colors.red,
                ),
                MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Diet Recommendation"),
                            content: Text(
                                "Salad: 1.5g\n\nCarrot: 1.5g\n\nTomato: 1.5g"),
                            actions: [
                              FlatButton(
                                child: Text("Close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    "Lose Weight",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  color: Colors.green,
                ),
              ],
            ),
          ),
          Flexible(
            child: FutureBuilder(
              future:
                  Provider.of<FetchPreviousExcercise>(context, listen: false)
                      .fetchPreviousExcercise(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return Consumer<FetchPreviousExcercise>(
                    builder: (context, exercies, child) {
                      List temp = exercies.pastExcercise;

                      return ListView.builder(
                        itemCount: temp.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(temp[index].name),
                            subtitle: Text(temp[index].date),
                            trailing: Text(temp[index].calories.toString()),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    ));
  }
}
