import 'package:flutter/material.dart';

enum StockLevel {
  low, // منخفض
  normal, // في الحالة العادية
  full, // مليان
}

class FabricStockModel {
  final String id;
  final String name;
  final Color color;
  final String colorName;
  final String code;
  final int quantity;
  final int cut;
  final StockLevel status;
  final String date;

  const FabricStockModel({
    required this.id,
    required this.name,
    required this.color,
    required this.colorName,
    required this.code,
    required this.quantity,
    required this.cut,
    required this.status,
    required this.date,
  });

  /// Convert From Map → Model
  factory FabricStockModel.fromMap(Map<String, dynamic> map) {
    return FabricStockModel(
      id: map['id'],
      name: map['name'],
      color: Color(int.parse('0xff${(map['color'] ?? '#000000').substring(1)}')),
      colorName: map['colorName'],
      code: map['code'],
      quantity: map['quantity'],
      cut: map['cut'],
      status: StockLevel.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => StockLevel.normal,
      ),
      date: map['date'],
    );
  }

  /// Convert From Model → Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': '#${color.toARGB32().toRadixString(16).substring(2)}',
      'colorName': colorName,
      'code': code,
      'quantity': quantity,
      'cut': cut,
      'status': status.name,
      'date': date,
    };
  }
}
