import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../profile/data/models/profile_model.dart';
import '../../data/models/invoice_model.dart';
import '../../data/services/pdf_invoice_generator.dart';
import 'client_section.dart';
import 'header_section.dart';
import 'icon_button_dark.dart';
import 'invoice_meta_section.dart';
import 'invoice_title_section.dart';
import 'items_table_section.dart';
import 'notes_section.dart';
import 'total_section.dart';

class InvoicesBottomSheet extends StatefulWidget {
  const InvoicesBottomSheet({super.key, required this.invoice});

  final InvoiceModel invoice;

  @override
  State<InvoicesBottomSheet> createState() => _InvoicesBottomSheetState();
}

class _InvoicesBottomSheetState extends State<InvoicesBottomSheet> {
  GlobalKey invoiceKey = GlobalKey();
  ProfileModel? profileData;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      child: Column(
        children: [
          // أزرار الطباعة والمشاركة
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButtonDark(
                  icon: Icons.share_outlined,
                  onTap: () async {
                    // final pdfData = await generatePdf(profileData);
                    final pdfGenerator = PdfInvoiceGenerator(
                      invoice: widget.invoice,
                      profile: profileData,
                    );
                    final pdfData = await pdfGenerator.generate();
                    final file = XFile.fromData(
                      pdfData,
                      name: "invoice.pdf",
                      mimeType: "application/pdf",
                    );

                    await SharePlus.instance.share(
                      ShareParams(
                        text: 'فاتورة مبيعات', // نص اختياري
                        files: [file],
                      ),
                    );
                  },
                ),
                const SizedBox(width: 16),
                IconButtonDark(
                  icon: Icons.print_outlined,
                  onTap: () async {
                    // final pdfData = await generatePdf(profileData);
                    final pdfGenerator = PdfInvoiceGenerator(
                      invoice: widget.invoice,
                      profile: profileData,
                    );
                    final pdfData = await pdfGenerator.generate();
                    await Printing.layoutPdf(onLayout: (format) async => pdfData);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: RepaintBoundary(
              key: invoiceKey,
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
                      InvoiceMetaSection(invoice: widget.invoice),

                      ///اسم العميل
                      ClientSection(invoice: widget.invoice),

                      ///جدول الفاتوره
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ItemsTableSection(
                          isDelete: false,
                          listProduct: widget.invoice.items,
                        ),
                      ),

                      ///اجمالى الفاتوره
                      TotalSection(invoice: widget.invoice),

                      ///ملاحظات
                      NotesSection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<ProfileModel?> getData() async {
    final data = await Pref.getStringFromPref(key: AppStrings.profileDataKey);
    if (data == null) {
      return null;
    }

    return ProfileModel.fromJson(jsonDecode(data) as Map<String, dynamic>);
  }

  void _loadProfile() async {
    final profile = await getData();

    if (!mounted) return;

    setState(() {
      profileData = profile;
    });
  }
}
