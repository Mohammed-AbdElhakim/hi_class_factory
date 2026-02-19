import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ColorPickerDialog extends StatefulWidget {
  final Color initialColor;

  const ColorPickerDialog({super.key, required this.initialColor});

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  late Color selected;

  final Map<Color, String> colorNames = {
    Colors.red: "أحمر",
    Colors.green: "أخضر",
    Colors.blue: "أزرق",
    Colors.yellow: "أصفر",
    Colors.orange: "برتقالي",
    Colors.purple: "بنفسجي",
    Colors.black: "أسود",
    Colors.white: "أبيض",
    Colors.brown: "بني",
    Colors.grey: "رمادي",
    Colors.teal: "تركوازي",
    Colors.pink: "زهري",
    Colors.cyan: "سماوي",
    Colors.indigo: "نيلي",
    Colors.lime: "ليموني",
    Colors.amber: "كهرماني",
    Colors.deepOrange: "برتقالي غامق",
    Colors.deepPurple: "بنفسجي غامق",
    Colors.lightBlue: "أزرق فاتح",
    Colors.lightGreen: "أخضر فاتح",
    Colors.blueGrey: "أزرق رمادي",
    Colors.redAccent: "أحمر فاتح",
    Colors.greenAccent: "أخضر فاتح",
    Colors.blueAccent: "أزرق فاتح",
    Colors.yellowAccent: "أصفر فاتح",
    Colors.orangeAccent: "برتقالي فاتح",
    Colors.purpleAccent: "بنفسجي فاتح",
    Colors.pinkAccent: "زهري فاتح",
  };

  @override
  void initState() {
    super.initState();
    selected = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("اختر اللون"),
      content: SizedBox(
        width: double.maxFinite,
        // تحديد أقصى ارتفاع
        height: MediaQuery.of(context).size.height * 0.5,
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: colorNames.entries.map((entry) {
              final color = entry.key;
              final name = entry.value;
              final isSelected = selected == color;

              return Container(
                padding: isSelected ? EdgeInsets.symmetric(vertical: 8) : EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isSelected
                      ? AppColors.background.withValues(alpha: .15)
                      : Colors.transparent,
                ),
                child: GestureDetector(
                  onTap: () => setState(() => selected = color),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 50,
                        child: Text(
                          name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text("إلغاء"),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, selected),
          child: const Text("تأكيد"),
        ),
      ],
    );
  }
}
