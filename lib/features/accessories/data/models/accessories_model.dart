import 'package:flutter/material.dart';

class AccessoriesModel {
  final String id;
  final String title;
  final Color? color;
  final String? size;
  final String? type;
  final bool isLow;
  final int qty;

  const AccessoriesModel({
    required this.id,
    required this.title,
    this.color,
    this.size,
    this.type,
    required this.isLow,
    required this.qty,
  });

  /// 🔹 fromJson (جاي من Firebase)
  factory AccessoriesModel.fromJson(Map<String, dynamic> json) {
    return AccessoriesModel(
      id: json['id'],
      title: json['title'],
      color: json['color'] != null ? Color(json['color']) : null,
      size: json['size'],
      type: json['type'],
      isLow: json['isLow'] ?? false,
      qty: json['qty'] ?? 0,
    );
  }

  /// 🔹 toJson (رايح لـ Firebase)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'color': color?.toARGB32(), // نحفظها int
      'size': size,
      'type': type,
      'isLow': isLow,
      'qty': qty,
    };
  }

  /// 🔹 copyWith (لما تيجي تعدل عنصر)
  AccessoriesModel copyWith({
    String? id,
    String? title,
    Color? color,
    String? size,
    String? type,
    bool? isLow,
    int? qty,
  }) {
    return AccessoriesModel(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      size: size ?? this.size,
      type: type ?? this.type,
      isLow: isLow ?? this.isLow,
      qty: qty ?? this.qty,
    );
  }
}
