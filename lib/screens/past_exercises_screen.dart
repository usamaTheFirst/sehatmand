import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sehatmand/providers/excercise_provider.dart';

class PastExercisesScreen extends StatelessWidget {
  const PastExercisesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: Provider.of<FetchPreviousExcercise>(context, listen: false)
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
    ));
  }
}
