import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ChartUi extends StatelessWidget {
  const ChartUi({super.key});

  @override
  Widget build(BuildContext context) {
  
    return  Scaffold(
        body: Center(
      child: GestureDetector(
        onTap: () {
    m(context);
          
        },
        child: Container(
          color: Colors.amber,
          height: 500,
          width: 500,
        
        ),
      ),
    ));
  }
}

Future<void> m(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: const BeveledRectangleBorder(),
        // title: const TextFontWidget(text: 'Please wait ...', fontsize: 12,fontWeight: FontWeight.bold,),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: SfRadialGauge(
                    backgroundColor: Colors.transparent,
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 100,
                        showLabels: false,
                        showTicks: false,
                        radiusFactor: 0.8,
                        axisLineStyle: const AxisLineStyle(
                            cornerStyle: CornerStyle.bothFlat,
                            color: Colors.black12,
                            dashArray: [10, 8],
                            thickness: 32),
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            angle: 90,
                            positionFactor: 0.1,
                            widget: Text(
                              '${(50 * 1).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                        pointers: const <GaugePointer>[
                          RangePointer(
                            value: 50,
                            dashArray: [10, 8],
                            cornerStyle: CornerStyle.bothFlat,
                            width: 32,
                            sizeUnit: GaugeSizeUnit.logicalPixel,
                            color: Colors.lightBlueAccent,
                          ),
                          MarkerPointer(value: 50, color: Color(0xFFEE0979))
                        ],
                      ),
                    ]),
              ),
            ],
          ),
        ),
      );
    },
  );
}
