
import 'package:flutter/material.dart';

class TipSlider extends StatelessWidget {
  const TipSlider({
    super.key,
    required this.sliderValue,
    required this.onSliderChange,
  });

  final double sliderValue;
final ValueChanged<double> onSliderChange;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: sliderValue,
      onChanged: (value) {
        onSliderChange(value);
      },
      min: 0.0,
      max: 0.5,
      divisions: 5,
      label: '${(sliderValue * 100).round()}%',
    );
  }
}
