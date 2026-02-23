import 'package:flutter/material.dart';

import 'info_row.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // بيانات المصنع
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'هاي كلاس',
                  style: TextStyle(
                    color: Color(0xFFCC0000),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Hi Class ',
                  style: TextStyle(
                    color: Color(0xFFCC0000),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                InfoRow(
                  icon: Icons.factory_outlined,
                  text: 'مصنع ملابس جاهزة - جملة وقطاعي',
                ),
                InfoRow(icon: Icons.phone, text: '01006875972 | 01203483502'),
                InfoRow(icon: Icons.location_on, text: 'طنامل الشرقى، أجا - الدقهلية '),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // لوجو المصنع
          Container(
            width: 100,
            height: 80,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF2A1500),
            ),
            child: ClipOval(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Image.asset("assets/images/logo_img.png", fit: BoxFit.contain),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
