import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sliderBackgroundColorProvider =
    StateNotifierProvider<SliderBackgroundColorNotifier, StateBackgroundColor>(
        (ref) {
  return SliderBackgroundColorNotifier();
});

class SliderBackgroundColorNotifier
    extends StateNotifier<StateBackgroundColor> {
  // Color color = Colors.red;

  SliderBackgroundColorNotifier()
      : super(StateBackgroundColor(color: Colors.transparent));

  void update(Color color) {
    state = StateBackgroundColor(color: color);
  }
}

class StateBackgroundColor {
  Color color = Colors.transparent;
  // double opacity;

  StateBackgroundColor({
    required this.color,
    // required this.opacity,
  });
}
