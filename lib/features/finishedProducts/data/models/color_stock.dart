import 'dart:ui';

class ColorStock {
  final String name;
  final int qty;
  final Color color;

  const ColorStock(this.name, this.qty, this.color);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'qty': qty,
      'colorHex': '#${color.toARGB32().toRadixString(16).substring(2)}',
    };
  }

  factory ColorStock.fromMap(Map<String, dynamic> map) {
    return ColorStock(
      map['name'] ?? '',
      map['qty'] ?? 0,
      Color(int.parse('0xff${(map['colorHex'] ?? '#000000').substring(1)}')),
    );
  }
}
