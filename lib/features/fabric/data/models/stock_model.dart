import 'package:flutter/material.dart';

class StockModel {
  final String id;
  final String name;
  final Color color;
  final String colorName;
  final String code;
  final int quantity;
  final int cut;
  final String status;

  const StockModel({
    required this.id,
    required this.name,
    required this.color,
    required this.colorName,
    required this.code,
    required this.quantity,
    required this.cut,
    required this.status,
  });

  /// Convert From Map → Model
  factory StockModel.fromMap(Map<String, dynamic> map) {
    return StockModel(
      id: map['id'],
      name: map['name'],
      color: map['color'],
      colorName: map['colorName'],
      code: map['code'],
      quantity: map['quantity'],
      cut: map['cut'],
      status: map['status'],
    );
  }

  /// Convert From Model → Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'colorName': colorName,
      'code': code,
      'quantity': quantity,
      'cut': cut,
      'status': status,
    };
  }
}
