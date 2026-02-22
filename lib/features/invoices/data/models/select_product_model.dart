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
