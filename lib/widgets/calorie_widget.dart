import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CalorieWidget extends StatelessWidget {
  const CalorieWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('calorie_tracker')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            var calorie = snapshot.data?.get("calories");

            print("cal??????????????? $calorie");

            return SizedBox(
              width: 150,
              height: 170,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Flexible(
                  child: SfRadialGauge(
                      // title: GaugeTitle(
                      //     text: 'Calories Count',
                      //     textStyle: const TextStyle(fontSize: 15)),
                      axes: <RadialAxis>[
                        RadialAxis(
                          axisLineStyle: AxisLineStyle(
                            thickness: 0.1,
                            thicknessUnit: GaugeSizeUnit.factor,
                          ),
                          maximum: 1000,
                          showLabels: false,
                          pointers: <GaugePointer>[
                            RangePointer(
                              value: calorie,
                              width: 0.1,
                              sizeUnit: GaugeSizeUnit.factor,
                              gradient: const SweepGradient(colors: <Color>[
                                Color(0xFFCC2B5E),
                                Color(0xFF753A88)
                              ], stops: <double>[
                                0.25,
                                0.75
                              ]),
                            ),
                            MarkerPointer(
                                value: calorie,
                                markerHeight: 20,
                                markerWidth: 20,
                                enableDragging: true,
                                overlayRadius: 15,
                                overlayColor: Colors.red.withOpacity(0.12),
                                markerType: MarkerType.circle),
                          ],
                          annotations: [
                            GaugeAnnotation(
                                widget: Container(
                                    child: Text('$calorie',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold))),
                                angle: 90,
                                positionFactor: 0),
                          ],
                        ),
                      ]),
                ),
                Text(
                  'Calories',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ]),
            );
          }

          return Center(child: CircularProgressIndicator());
        });
  }
}
