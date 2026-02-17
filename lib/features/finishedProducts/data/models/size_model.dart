import 'color_stock.dart';

class SizeModel {
  final String size;
  final bool isLow;
  final List<ColorStock> colors;

  const SizeModel({required this.size, required this.colors, this.isLow = false});

  int get totalQty => colors.fold(0, (sum, color) => sum + color.qty);

  Map<String, dynamic> toMap() {
    return {
      'size': size,
      'isLow': isLow,
      'colors': colors.map((e) => e.toMap()).toList(),
    };
  }

  factory SizeModel.fromMap(Map<String, dynamic> map) {
    return SizeModel(
      size: map['size'] ?? '',
      isLow: map['isLow'] ?? false,
      colors: List<Map<String, dynamic>>.from(
        map['colors'] ?? [],
      ).map((e) => ColorStock.fromMap(e)).toList(),
    );
  }
}
