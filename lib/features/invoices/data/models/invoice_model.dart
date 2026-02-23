import 'select_product_model.dart';

enum InvoiceStatus { paid, pending, overdue }

class InvoiceModel {
  final String id;
  final String invoiceNumber;
  final String customerName;
  final DateTime date;
  final List<SelectProductModel> items;
  final double totalBeforeDiscount;
  final double discount;
  final double totalAfterDiscount;
  final InvoiceStatus status; // paid - pending - overdue

  InvoiceModel({
    required this.id,
    required this.invoiceNumber,
    required this.customerName,
    required this.date,
    required this.items,
    required this.totalBeforeDiscount,
    required this.discount,
    required this.totalAfterDiscount,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "invoiceNumber": invoiceNumber,
      "customerName": customerName,
      "date": date.toIso8601String(),
      "items": items.map((e) => e.toJson()).toList(),
      "totalBeforeDiscount": totalBeforeDiscount,
      "discount": discount,
      "totalAfterDiscount": totalAfterDiscount,
      "status": status.name,
    };
  }

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'] as String,
      invoiceNumber: json['invoiceNumber'] as String,
      customerName: json['customerName'] as String,
      date: DateTime.parse(json['date'] as String),
      items: (json['items'] as List)
          .map((e) => SelectProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalBeforeDiscount: (json['totalBeforeDiscount'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      totalAfterDiscount: (json['totalAfterDiscount'] as num).toDouble(),
      status: InvoiceStatus.values.byName(json['status'] as String),
    );
  }
  InvoiceModel copyWith({
    String? id,
    String? invoiceNumber,
    String? customerName,
    DateTime? date,
    List<SelectProductModel>? items,
    double? totalBeforeDiscount,
    double? discount,
    double? totalAfterDiscount,
    InvoiceStatus? status,
  }) {
    return InvoiceModel(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      customerName: customerName ?? this.customerName,
      date: date ?? this.date,
      items: items ?? this.items,
      totalBeforeDiscount: totalBeforeDiscount ?? this.totalBeforeDiscount,
      discount: discount ?? this.discount,
      totalAfterDiscount: totalAfterDiscount ?? this.totalAfterDiscount,
      status: status ?? this.status,
    );
  }
}
