class SelectItemColorSizeModel {
  final String size;
  final int qty;
  final String color;

  SelectItemColorSizeModel({required this.size, required this.qty, required this.color});

  SelectItemColorSizeModel copyWith({String? size, int? qty, String? color}) {
    return SelectItemColorSizeModel(
      size: size ?? this.size,
      qty: qty ?? this.qty,
      color: color ?? this.color,
    );
  }
}
