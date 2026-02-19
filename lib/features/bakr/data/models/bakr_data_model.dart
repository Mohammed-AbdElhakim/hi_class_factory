import 'package:flutter/material.dart';

class BakrDataModel {
  final String code;
  final Color color;
  final bool isLow;
  final int qty;

  const BakrDataModel({
    required this.code,
    required this.color,
    required this.qty,
    required this.isLow,
  });

  /// ================= FROM MAP =================
  factory BakrDataModel.fromMap(Map<String, dynamic> map) {
    return BakrDataModel(
      code: map['code'],
      color: Color(
        int.parse('0xff${(map['color'] ?? '#000000').substring(1)}'),
      ), // نحول int -> Color
      qty: map['qty'],
      isLow: map['isLow'], // SQLite بيخزن bool كـ 0 و 1
    );
  }

  /// ================= TO MAP =================
  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'color': "#${color.toARGB32().toRadixString(16).substring(2)}", // نحول Color -> int
      'qty': qty,
      'isLow': isLow,
    };
  }
}
