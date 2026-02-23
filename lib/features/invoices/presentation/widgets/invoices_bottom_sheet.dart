import 'package:flutter/material.dart';

import '../../data/models/invoice_model.dart';
import 'client_section.dart';
import 'header_section.dart';
import 'invoice_meta_section.dart';
import 'invoice_title_section.dart';
import 'items_table_section.dart';
import 'notes_section.dart';
import 'total_section.dart';

class InvoicesBottomSheet extends StatelessWidget {
  const InvoicesBottomSheet({super.key, required this.invoice});

  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ///راس الفاتوره
              HeaderSection(),

              ///المشاركه والطباعه
              InvoiceTitleSection(),

              ///رقن الفاتوره والوقت
              InvoiceMetaSection(invoice: invoice),

              ///اسم العميل
              ClientSection(invoice: invoice),

              ///جدول الفاتوره
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ItemsTableSection(isDelete: false, listProduct: invoice.items),
              ),

              ///اجمالى الفاتوره
              TotalSection(invoice: invoice),

              ///ملاحظات
              NotesSection(),
            ],
          ),
        ),
      ),
    );
  }
}
