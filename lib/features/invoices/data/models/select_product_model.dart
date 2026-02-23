class SelectProductModel {
  final String id;
  final String productName;
  final String size;
  final int qtyInStore;
  final int selectQty;
  final String colorName;
  final double price;

  SelectProductModel({
    required this.size,
    required this.id,
    required this.productName,
    required this.qtyInStore,
    required this.selectQty,
    required this.colorName,
    required this.price,
  });
  factory SelectProductModel.fromJson(Map<String, dynamic> json) {
    return SelectProductModel(
      id: json['id'] as String,
      productName: json['productName'] as String,
      size: json['size'] as String,
      qtyInStore: json['qtyInStore'] as int,
      selectQty: json['selectQty'] as int,
      colorName: json['colorName'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "size": size,
      "qtyInStore": qtyInStore,
      "productName": productName,
      "selectQty": selectQty,
      "colorName": colorName,
      "price": price,
    };
  }

  SelectProductModel copyWith({
    String? id,
    String? productName,
    String? size,
    int? qtyInStore,
    int? selectQty,
    String? colorName,
    double? price,
  }) {
    return SelectProductModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      size: size ?? this.size,
      qtyInStore: qtyInStore ?? this.qtyInStore,
      selectQty: selectQty ?? this.selectQty,
      colorName: colorName ?? this.colorName,
      price: price ?? this.price,
    );
  }
}
