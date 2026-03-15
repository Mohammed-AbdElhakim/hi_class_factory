import 'package:flutter/material.dart';
import 'package:hi_class_factory/generated/l10n.dart';

import '../../../../core/constants/app_colors.dart';

class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({super.key});

  @override
  State<ColorPickerDialog> createState() => ColorPickerDialogState();
}

class ColorPickerDialogState extends State<ColorPickerDialog> {
  late Color selected;

  @override
  void initState() {
    super.initState();
    selected = Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    final Map<Color, String> colorNames = {
      Colors.red: S.of(context).color_red,
      Colors.green: S.of(context).color_green,
      Colors.blue: S.of(context).color_blue,
      Colors.yellow: S.of(context).color_yellow,
      Colors.orange: S.of(context).color_orange,
      Colors.purple: S.of(context).color_purple,
      Colors.black: S.of(context).color_black,
      Colors.white: S.of(context).color_white,
      Colors.brown: S.of(context).color_brown,
      Colors.grey: S.of(context).color_grey,
      Colors.teal: S.of(context).color_teal,
      Colors.pink: S.of(context).color_pink,
      Colors.cyan: S.of(context).color_cyan,
      Colors.indigo: S.of(context).color_indigo,
      Colors.lime: S.of(context).color_lime,
      Colors.amber: S.of(context).color_amber,
      Colors.deepOrange: S.of(context).color_deep_orange,
      Colors.deepPurple: S.of(context).color_deep_purple,
      Colors.lightBlue: S.of(context).color_light_blue,
      Colors.lightGreen: S.of(context).color_light_green,
      Colors.blueGrey: S.of(context).color_blue_grey,
      Colors.redAccent: S.of(context).color_red_accent,
      Colors.greenAccent: S.of(context).color_green_accent,
      Colors.blueAccent: S.of(context).color_blue_accent,
      Colors.yellowAccent: S.of(context).color_yellow_accent,
      Colors.orangeAccent: S.of(context).color_orange_accent,
      Colors.purpleAccent: S.of(context).color_purple_accent,
      Colors.pinkAccent: S.of(context).color_pink_accent,
    };
    return AlertDialog(
      title: Text(S.of(context).choose_color),
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
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          // border: Border.all(
                          //   color: isSelected ? Colors.black : Colors.transparent,
                          //   width: 2,
                          // ),
                        ),
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
          child: Text(S.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () =>
              Navigator.pop(context, {"color": selected, "name": colorNames[selected]!}),
          child: Text(S.of(context).confirm),
        ),
      ],
    );
  }
}
