import 'package:flutter/material.dart';

import 'color_input_model.dart';

class SizeInputModel {
  final sizeController = TextEditingController();
  final List<ColorInputModel> colors = [];

  void addColor() {
    colors.add(ColorInputModel());
  }

  void removeColor(ColorInputModel color) {
    color.dispose();
    colors.remove(color);
  }

  void dispose() {
    sizeController.dispose();
    for (final color in colors) {
      color.dispose();
    }
  }
}
