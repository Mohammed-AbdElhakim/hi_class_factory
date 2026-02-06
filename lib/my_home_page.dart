import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/firebase/firebase_service.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("${FirebaseService().currentUser!.email}")));
  }
}
