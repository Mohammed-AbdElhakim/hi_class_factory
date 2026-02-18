import 'package:flutter/material.dart';

class Invoices extends StatelessWidget {
  const Invoices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الفواتير")),
      body: const Center(
        child: Text("فواتير"),
      ),
    );
  }
}