import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff904A42),
        title: const Text(
          "المف الشخصي",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE8D2A8),
              border: Border.all(color: Colors.red.withValues(alpha: 0.2), width: 4),
            ),
            child: const Icon(Icons.person, size: 60, color: Colors.white),
          ),

          const SizedBox(height: 12),

          const Text(
            "الحاج وائل عبدالمنعم",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 5),

          const Text("مدير المصنع", style: TextStyle(color: Colors.grey)),

          const SizedBox(height: 5),

          const Text(
            "Hi Class Factory",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
