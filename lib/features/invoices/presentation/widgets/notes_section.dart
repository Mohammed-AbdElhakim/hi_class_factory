import 'package:flutter/material.dart';
import 'package:hi_class_factory/generated/l10n.dart';

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
            children: [
              Text(
                S.of(context).notes,
                style: TextStyle(
                  color: Color(0xFFCC0000),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 8),
              Text(
                S.of(context).note1,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 13, height: 1.6),
              ),
              Text(
                S.of(context).note2,
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
