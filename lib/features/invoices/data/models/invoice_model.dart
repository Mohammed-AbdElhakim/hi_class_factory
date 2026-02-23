import 'package:hi_class_factory/features/invoices/data/models/select_product_model.dart';

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
