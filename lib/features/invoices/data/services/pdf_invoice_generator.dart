import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:hi_class_factory/core/constants/app_assets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../profile/data/models/profile_model.dart';
import '../../data/models/invoice_model.dart';

class PdfInvoiceGenerator {
  final InvoiceModel invoice;
  final ProfileModel? profile;

  PdfInvoiceGenerator({required this.invoice, this.profile});

  Future<Uint8List> generate() async {
    final pdf = pw.Document();

    // تحميل الخط العربي
    final ttf = pw.Font.ttf(await rootBundle.load("assets/fonts/Tajawal-Regular.ttf"));

    // تحميل اللوجو
    final logoBytes = (await rootBundle.load(AppAssets.logoImg)).buffer.asUint8List();
    final logoWidget = pw.Container(
      width: 80,
      height: 80,
      decoration: pw.BoxDecoration(
        shape: pw.BoxShape.circle,
        color: PdfColor.fromHex("#2A1500"),
      ),
      child: pw.Padding(
        padding: const pw.EdgeInsets.all(4),
        child: pw.ClipOval(
          child: pw.Image(pw.MemoryImage(logoBytes), fit: pw.BoxFit.contain),
        ),
      ),
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.rtl,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        theme: pw.ThemeData.withFont(base: ttf),
        build: (context) => [
          /// Header مع اللوجو
          pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: 20),
                      pw.Text(
                        profile?.name ?? '',
                        style: pw.TextStyle(
                          font: ttf,
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColor.fromHex("#CC0000"),
                        ),
                      ),
                      pw.Text(profile?.description ?? ''),
                      pw.Text('${profile?.phone1 ?? ''} | ${profile?.phone2 ?? ''}'),
                      pw.Text(profile?.address ?? ''),
                    ],
                  ),
                ),
                pw.SizedBox(width: 12),
                logoWidget,
              ],
            ),
          ),
          pw.SizedBox(height: 16),

          /// عنوان الفاتورة
          pw.Align(
            alignment: pw.AlignmentDirectional.centerStart,
            child: pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'فاتورة مبيعات',
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 22,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    'تفاصيل المعاملة المالية',
                    style: pw.TextStyle(font: ttf, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),

          pw.SizedBox(height: 16),

          /// بيانات الفاتورة
          pw.Align(
            alignment: pw.AlignmentDirectional.centerStart,
            child: pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('رقم الفاتورة: ${invoice.invoiceNumber}'),
                  pw.Text('التاريخ: ${invoice.date}'),
                ],
              ),
            ),
          ),

          pw.SizedBox(height: 16),

          /// العميل
          pw.Align(
            alignment: pw.AlignmentDirectional.centerStart,
            child: pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'اسم العميل',
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 18,
                      color: PdfColor.fromHex("#CC0000"),
                    ),
                  ),
                  pw.Text(
                    invoice.customerName,
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 17,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          pw.SizedBox(height: 16),

          /// جدول الأصناف
          pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.TableHelper.fromTextArray(
              border: pw.TableBorder.all(color: PdfColors.brown),
              headerStyle: pw.TextStyle(
                font: ttf,
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.white,
              ),
              headerDecoration: pw.BoxDecoration(color: PdfColors.brown),
              cellStyle: pw.TextStyle(font: ttf, fontSize: 12),
              data: <List<String>>[
                ['الصنف', 'العدد', 'سعر الوحدة', 'الإجمالي'],
                ...invoice.items.map(
                  (item) => [
                    "${item.productName} - ${item.size} - ${item.colorName}",
                    item.selectQty.toString(), // العدد
                    item.price.toStringAsFixed(2), // سعر الوحدة
                    (item.price * item.selectQty).toStringAsFixed(2), // الإجمالي
                  ],
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 16),

          /// الاجمالي
          pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('إجمالي الأصناف'),
                    pw.Text(invoice.totalBeforeDiscount.toString()),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'الخصم (${((invoice.discount / invoice.totalAfterDiscount) * 100).toStringAsFixed(2)}%)',
                    ),
                    pw.Text(invoice.discount.toString()),
                  ],
                ),
                pw.Divider(),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'الإجمالي الكلي',
                      style: pw.TextStyle(
                        font: ttf,
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      '${invoice.totalAfterDiscount} ج.م',
                      style: pw.TextStyle(
                        font: ttf,
                        fontSize: 22,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColor.fromHex("#CC0000"),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'فقط ${_convertToArabicWords(invoice.totalAfterDiscount)} لا غير',
                  style: pw.TextStyle(font: ttf, fontSize: 12),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 16),

          /// الملاحظات
          pw.Align(
            alignment: pw.AlignmentDirectional.centerStart,
            child: pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'ملاحظات',
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 15,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromHex("#CC0000"),
                    ),
                  ),
                  pw.Text(
                    '- البضاعة المباعة لا ترد ولا تستبدل بعد 14 يوماً.',
                    style: pw.TextStyle(font: ttf, fontSize: 13),
                  ),
                  pw.Text(
                    '- يجب إحضار أصل الفاتورة عند الاستبدال.',
                    style: pw.TextStyle(font: ttf, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return pdf.save();
  }

  String _convertToArabicWords(double total) {
    // لو عندك مكتبة Tafqeet، استخدمها هنا
    int integerPart = total.floor();
    int decimalPart = ((total - integerPart) * 100).round();
    if (decimalPart == 0) {
      return "جنيهاً مصريا $integerPart";
    } else {
      return "جنيهاً مصريا $integerPart و $decimalPart قرشاً";
    }
  }
}
