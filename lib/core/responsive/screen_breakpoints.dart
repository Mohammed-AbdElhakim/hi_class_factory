// core
import 'package:flutter/material.dart';

class ScreenBreakpoints {
  static const tablet = 750;
  static const desktop = 1024;
  static late double width, height;
  static void init(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    width = MediaQuery.sizeOf(context).width;
  }
}
