import 'package:flutter/material.dart';

class NotesSection extends StatelessWidget {
  const NotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'ملاحظات',
                style: TextStyle(
                  color: Color(0xFFCC0000),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '- البضاعة المباعة لا ترد ولا تستبدل بعد 14 يوماً.',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 13, height: 1.6),
              ),
              Text(
                '- يجب إحضار أصل الفاتورة عند الاستبدال.',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 13, height: 1.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
