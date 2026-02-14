import 'package:flutter/material.dart';

class WarehouseDetailsView extends StatelessWidget {
  const WarehouseDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الانتاج")),
      body: const Center(
        child: Text("الانتاج"),
      ),
    );
  }
}
