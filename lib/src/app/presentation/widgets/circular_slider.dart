import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smart_refrigerator/src/app/presentation/widgets/custom_draw.dart';
import 'package:smart_refrigerator/src/core/utils/circle_utils.dart';

class CircularSlider extends StatefulWidget {
  final double initialValue;
  final ValueChanged<double> onChanged;

  const CircularSlider({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<CircularSlider> createState() => _CircularSliderState();
}

class _CircularSliderState extends State<CircularSlider> {
  double progressVal = 0.5;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) {
            return SweepGradient(
              startAngle: degToRad(0),
              endAngle: degToRad(184),
              colors: [Colors.blue[200]!, Colors.grey.withAlpha(50)],
              stops: [progressVal, progressVal],
              transform: GradientRotation(
                degToRad(178),
              ),
            ).createShader(rect);
          },
          child: const Center(child: CustomArc()),
        ),
        Center(
          child: Container(
            width: kDiameter - 30,
            height: kDiameter - 30,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 20,
                  style: BorderStyle.solid,
                ),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 30,
                      spreadRadius: 10,
                      color: Colors.blue.withAlpha(
                          normalize(progressVal * 20000, 100, 255).toInt()),
                      offset: const Offset(1, 3))
                ]),
            child: SleekCircularSlider(
              min: kMinDegree,
              max: kMaxDegree,
              initialValue: widget.initialValue,
              appearance: CircularSliderAppearance(
                startAngle: 180,
                angleRange: 180,
                size: kDiameter - 30,
                customWidths: CustomSliderWidths(
                  trackWidth: 10,
                  shadowWidth: 0,
                  progressBarWidth: 01,
                  handlerSize: 15,
                ),
                customColors: CustomSliderColors(
                  hideShadow: true,
                  progressBarColor: Colors.transparent,
                  trackColor: Colors.transparent,
                  dotColor: Colors.blue,
                ),
              ),
              onChange: (value) {
                setState(() {
                  progressVal = normalize(value, kMinDegree, kMaxDegree);
                });
                widget.onChanged(normalize(value, kMinDegree, kMaxDegree));
              },
              innerWidget: (percentage) {
                return Center(
                  child: Text(
                    '${percentage.toInt()}°c',
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'Poppins',
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
