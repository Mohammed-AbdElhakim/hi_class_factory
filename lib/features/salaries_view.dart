import 'package:flutter/material.dart';

class Salaries extends StatelessWidget {
  const Salaries({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الرواتب")),
      body: const Center(
        child: Text("الرواتب"),
      ),
    );
  }
}
