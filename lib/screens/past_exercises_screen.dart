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
          MaterialButton(
            onPressed: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minWidth: MediaQuery.of(context).size.width * 0.8,
            child: Text("Gain Weight"),
            color: Theme.of(context).colorScheme.secondary,
          ),
          MaterialButton(
            onPressed: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minWidth: MediaQuery.of(context).size.width * 0.8,
            child: Text("Lose Weight"),
            color: Theme.of(context).colorScheme.secondary,
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
