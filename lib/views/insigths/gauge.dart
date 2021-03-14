import 'package:flutter/material.dart';
import 'package:my_app/models/receipts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Gauge extends StatelessWidget {
  final bool isCardView = true;
  final ReceiptsModel receipts;
  const Gauge({Key key, this.receipts}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          showAxisLine: false,
          showLabels: false,
          showTicks: false,
          startAngle: 180,
          endAngle: 360,
          minimum: 0,
          maximum: 2,
          canScaleToFit: true,
          radiusFactor: 0.79,
          pointers: <GaugePointer>[
            NeedlePointer(
                needleStartWidth: 1,
                needleEndWidth: 5,
                lengthUnit: GaugeSizeUnit.factor,
                needleLength: 0.7,
                value: receipts.getC02Score,
                knobStyle: KnobStyle(knobRadius: 0.05)),
          ],
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 0.66,
              startWidth: 0.45,
              sizeUnit: GaugeSizeUnit.factor,
              endWidth: 0.45,
              color: const Color(0xFF64BE00),
            ),
            GaugeRange(
              startValue: 0.66,
              endValue: 1.32,
              startWidth: 0.45,
              sizeUnit: GaugeSizeUnit.factor,
              endWidth: 0.45,
              color: const Color(0xFFFFBA00),
            ),
            GaugeRange(
              startValue: 1.32,
              endValue: 2,
              startWidth: 0.45,
              endWidth: 0.45,
              sizeUnit: GaugeSizeUnit.factor,
              color: const Color(0xFFDD3800),
            ),
          ],
        ),
        RadialAxis(
          showAxisLine: false,
          showLabels: false,
          showTicks: false,
          startAngle: 180,
          endAngle: 360,
          minimum: 0,
          maximum: 120,
          radiusFactor: 0.85,
          canScaleToFit: true,
          pointers: <GaugePointer>[
            MarkerPointer(
                markerType: MarkerType.text,
                text: 'Good',
                value: 20.5,
                textStyle: GaugeTextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isCardView ? 14 : 18,
                    fontFamily: 'Times'),
                offsetUnit: GaugeSizeUnit.factor,
                markerOffset: -0.12),
            MarkerPointer(
                markerType: MarkerType.text,
                text: 'Average',
                value: 60.5,
                textStyle: GaugeTextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isCardView ? 14 : 18,
                    fontFamily: 'Times'),
                offsetUnit: GaugeSizeUnit.factor,
                markerOffset: -0.12),
            MarkerPointer(
                markerType: MarkerType.text,
                text: 'Poor',
                value: 100.5,
                textStyle: GaugeTextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isCardView ? 14 : 18,
                    fontFamily: 'Times'),
                offsetUnit: GaugeSizeUnit.factor,
                markerOffset: -0.12)
          ],
        ),
      ],
    );
  }
}
