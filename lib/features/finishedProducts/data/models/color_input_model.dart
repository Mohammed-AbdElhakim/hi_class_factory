import 'package:flutter/material.dart';

class ColorInputModel {
  final nameController = TextEditingController();
  final qtyController = TextEditingController();
  Color selectedColor = Colors.grey;
  void dispose() {
    nameController.dispose();
    qtyController.dispose();
  }
}
