import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sehatmand/providers/excercise_provider.dart';
import 'package:sehatmand/providers/user-attributes-provider.dart';

class PastExercisesScreen extends StatefulWidget {
  const PastExercisesScreen({Key? key}) : super(key: key);

  @override
  State<PastExercisesScreen> createState() => _PastExercisesScreenState();
}

class _PastExercisesScreenState extends State<PastExercisesScreen> {
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
                  onPressed: () async {
                    String? message, suggestions;
                    var content;
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Weight Gain "),
                            content: CircularProgressIndicator(),
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

                    Provider.of<UserAttributesProvider>(context, listen: false)
                        .getWeightGainRecommendation()
                        .then((res) {
                      print(res);
                      print(res["bmi_message"]);
                      message = res["bmi_message"];
                      suggestions = res["suggestions"].join("\n");
                      content = SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(message!),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Food Recommendations"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(suggestions!),
                          ],
                        ),
                      );
                      setState(() {});
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Weight Gain "),
                              content: content,
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
                  onPressed: () async {
                    String? message, suggestions;
                    var content;
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Weight Loss "),
                            content: CircularProgressIndicator(),
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

                    Provider.of<UserAttributesProvider>(context, listen: false)
                        .getWeightLossRecommendation()
                        .then((res) {
                      print(res);
                      print(res["bmi_message"]);
                      message = res["bmi_message"];
                      suggestions = res["suggestions"].join("\n");
                      content = SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(message!),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Food Recommendations"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(suggestions!),
                          ],
                        ),
                      );
                      setState(() {});
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Weight Loss "),
                              content: content,
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
