import 'package:cloud_firestore/cloud_firestore.dart';

import 'size_model.dart';

class ProductModel {
  final String id;
  final String title;
  final String code;
  final List<SizeModel> sizes;

  const ProductModel({
    required this.title,
    required this.code,
    required this.sizes,
    required this.id,
  });

  int get totalUnits => sizes.fold(0, (total, size) => total + size.totalQty);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'code': code,
      'sizes': sizes.map((e) => e.toMap()).toList(),
      'createdAt': Timestamp.now(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      code: map['code'] ?? '',
      sizes: List<Map<String, dynamic>>.from(
        map['sizes'] ?? [],
      ).map((e) => SizeModel.fromMap(e)).toList(),
    );
  }
}
