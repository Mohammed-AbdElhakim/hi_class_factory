
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccessoriesDetailsView extends StatelessWidget {
  const AccessoriesDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الاكسسوارات")),
      body: const Center(
        child: Text("الاكسسوارات"),
      ),
    );
  }
}
