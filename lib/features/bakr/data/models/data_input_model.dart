import 'package:flutter/material.dart';

class DataInputModel {
  final codeController = TextEditingController();
  final qtyController = TextEditingController();
  Color selectedColor = Colors.grey;
  void dispose() {
    codeController.dispose();
    qtyController.dispose();
  }
}
