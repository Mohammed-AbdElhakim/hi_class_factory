import 'package:flutter/material.dart';

class ScreenMainBody extends StatelessWidget {
  const ScreenMainBody({super.key, required this.route});
  final String route;

  @override
  Widget build(BuildContext context) {
    return myWidget(route);
  }
}

Widget myWidget(String m){
  switch(m){
    case "/dashboard":
      return Center(child: Text("dashboard"),);
    case "/raw-store":
      return Center(child: Text("raw-store"),);
    case "/finished-store":
      return Center(child: Text("finished-store"),);
    case "/store-movement":
      return Center(child: Text("store-movement"),);
      case "/store-movement2":
      return Center(child: Text("store-movement2"),);
    default:
      return Center(child: Text("data"),);
  }
}