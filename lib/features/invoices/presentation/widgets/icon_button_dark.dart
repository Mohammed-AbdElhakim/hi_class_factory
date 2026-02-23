import 'package:flutter/material.dart';

class IconButtonDark extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const IconButtonDark({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black, width: .5),
        ),
        child: Icon(icon, color: Colors.black, size: 20),
      ),
    );
  }
}
