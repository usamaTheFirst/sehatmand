import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CalorieWidget extends StatelessWidget {
  const CalorieWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  maximum: 500,
                  showLabels: false,
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: 40,
                      width: 0.1,
                      sizeUnit: GaugeSizeUnit.factor,
                      gradient: const SweepGradient(
                          colors: <Color>[Color(0xFFCC2B5E), Color(0xFF753A88)],
                          stops: <double>[0.25, 0.75]),
                    ),
                    MarkerPointer(
                        value: 40,
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
                            child: Text('40.0',
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
}
