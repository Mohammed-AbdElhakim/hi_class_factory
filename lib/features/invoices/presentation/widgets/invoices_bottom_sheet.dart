import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:number_to_word_arabic/number_to_word_arabic.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../profile/data/models/profile_model.dart';
import '../../data/models/invoice_model.dart';
import '../../data/models/select_product_model.dart';
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
  Uint8List? logoBytes;
  pw.Font? ttf;
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

                    await Share.shareXFiles([file]);
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

  Future<Uint8List> generatePdf2(ProfileModel? profileData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            ///راس الفاتوره
            buildHeader(profileData),

            ///المشاركه والطباعه
            buildInvoiceTitle(),

            pw.SizedBox(height: 20),

            ///رقن الفاتوره والوقت
            buildInvoiceMeta(widget.invoice),

            ///اسم العميل
            buildClientSection(widget.invoice),

            ///جدول الفاتوره
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: 8),
              child: buildItemsTable(widget.invoice.items),
            ),

            ///اجمالى الفاتوره
            buildTotalSection(widget.invoice),

            ///ملاحظات
            buildNotesSection(),
          ];
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget buildHeader(ProfileModel? profile) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        /// بيانات المصنع
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.SizedBox(height: 30),

              pw.Text(
                profile?.name ?? "",
                style: pw.TextStyle(
                  font: ttf,
                  color: PdfColor.fromHex("#CC0000"),
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 12),

              pw.Text(profile?.description ?? "", style: pw.TextStyle(font: ttf)),
              pw.Text(
                '${profile?.phone1} | ${profile?.phone2}',
                style: pw.TextStyle(font: ttf),
              ),
              pw.Text(profile?.address ?? "", style: pw.TextStyle(font: ttf)),
            ],
          ),
        ),

        pw.SizedBox(width: 12),

        /// اللوجو
        buildLogoWidget(logoBytes!),
      ],
    );
  }

  pw.Widget buildLogoWidget(Uint8List logoBytes) {
    return pw.Container(
      width: 80, // نفس الحجم تقريباً
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
  }

  Future<ProfileModel?> getData() async {
    final data = await Pref.getStringFromPref(key: AppStrings.profileDataKey);
    if (data == null) {
      return null;
    }

    return ProfileModel.fromJson(jsonDecode(data) as Map<String, dynamic>);
  }

  void _loadProfile() async {
    final font = pw.Font.ttf(await rootBundle.load("assets/fonts/Tajawal-Regular.ttf"));
    final logo = (await rootBundle.load(AppAssets.logoImg)).buffer.asUint8List();
    final profile = await getData();

    if (!mounted) return;

    setState(() {
      ttf = font;
      logoBytes = logo;
      profileData = profile;
    });
  }

  pw.Widget buildInvoiceTitle() {
    return pw.Container(
      color: PdfColors.white,
      padding: const pw.EdgeInsets.all(8),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          // العنوان والوصف
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
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
        ],
      ),
    );
  }

  pw.Widget buildInvoiceMeta(InvoiceModel invoice) {
    return pw.Container(
      color: PdfColors.white,
      padding: const pw.EdgeInsets.all(8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'رقم الفاتورة:',
                style: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(invoice.invoiceNumber, style: pw.TextStyle(font: ttf)),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'التاريخ:',
                style: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                DateFormat('yyyy/MM/dd  -  hh:mm a', 'en').format(invoice.date),
                style: pw.TextStyle(font: ttf),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget buildClientSection(InvoiceModel invoice) {
    return pw.Container(
      color: PdfColors.white,
      padding: const pw.EdgeInsets.all(8),
      width: double.infinity,
      child: pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 16),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'اسم العميل',
              style: pw.TextStyle(
                font: ttf,
                color: PdfColor.fromHex("#CC0000"),
                fontSize: 18,
              ),
            ),
            pw.SizedBox(height: 6),
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
    );
  }

  pw.Widget buildItemsTable(List<SelectProductModel> products) {
    return pw.TableHelper.fromTextArray(
      headers: ['الصنف', 'العدد', 'سعر الوحدة', 'الإجمالي'],
      data: products.map((item) {
        return [
          "${item.productName} - ${item.size} - ${item.colorName}",
          item.selectQty.toString(), // العدد
          item.price.toStringAsFixed(2), // سعر الوحدة
          (item.price * item.selectQty).toStringAsFixed(2), // الإجمالي
        ];
      }).toList(),
      headerStyle: pw.TextStyle(
        font: ttf,
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.white,
      ),
      headerDecoration: pw.BoxDecoration(color: PdfColors.brown),
      cellAlignment: pw.Alignment.center,
      columnWidths: {
        0: const pw.FlexColumnWidth(3), // الصنف
        1: const pw.FlexColumnWidth(2), // العدد
        2: const pw.FlexColumnWidth(3), // سعر الوحدة
        3: const pw.FlexColumnWidth(3), // الإجمالي
      },
      cellStyle: pw.TextStyle(font: ttf, fontSize: 12),
    );
  }

  pw.Widget buildTotalSection(InvoiceModel invoice) {
    String totalText = getIntegerByArabic(invoice.totalAfterDiscount);

    double discountPercent = invoice.totalAfterDiscount != 0
        ? (invoice.discount / invoice.totalAfterDiscount) * 100
        : 0;

    return pw.Container(
      color: PdfColors.white,
      padding: const pw.EdgeInsets.all(16),
      child: pw.Column(
        children: [
          // إجمالي الأصناف
          buildTotalRow('إجمالي الأصناف', invoice.totalBeforeDiscount.toStringAsFixed(2)),

          pw.SizedBox(height: 8),

          // الخصم
          buildTotalRow(
            'الخصم (${discountPercent.toStringAsFixed(2)}%)',
            invoice.discount.toStringAsFixed(2),
          ),

          pw.Divider(color: PdfColor.fromHex("#5A2A00"), thickness: 1),
          pw.SizedBox(height: 8),

          // الإجمالي الكلي
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
                '${invoice.totalAfterDiscount.toStringAsFixed(2)} ج.م',
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

          // المبلغ كتابةً
          pw.Text(
            'فقط $totalText لا غير',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(font: ttf, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // دالة مساعدة لبناء صف TotalRow في PDF
  pw.Widget buildTotalRow(String label, String value) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(label, style: pw.TextStyle(font: ttf, fontSize: 14)),
        pw.Text(value, style: pw.TextStyle(font: ttf, fontSize: 14)),
      ],
    );
  }

  // دالة تحويل المبلغ للأرقام بالكلمات
  String getIntegerByArabic(double total) {
    int integerPart = total.floor();
    int decimalPart = ((total - integerPart) * 100).round();
    if (decimalPart == 0) {
      return "${Tafqeet.convert("$integerPart")} جنيهاً مصريا";
    } else if (decimalPart > 0) {
      return "${Tafqeet.convert("$integerPart")} جنيهاً مصريا و "
          "${Tafqeet.convert("$decimalPart")} قرشاً";
    }
    return '';
  }

  pw.Widget buildNotesSection() {
    return pw.Container(
      color: PdfColors.white,
      width: double.infinity,
      padding: const pw.EdgeInsets.all(16),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'ملاحظات',
            style: pw.TextStyle(
              font: ttf,
              color: PdfColor.fromHex("#CC0000"),
              fontWeight: pw.FontWeight.bold,
              fontSize: 15,
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            '- البضاعة المباعة لا ترد ولا تستبدل بعد 14 يوماً.',
            textAlign: pw.TextAlign.right,
            style: pw.TextStyle(font: ttf, fontSize: 13, height: 1.6),
          ),
          pw.Text(
            '- يجب إحضار أصل الفاتورة عند الاستبدال.',
            textAlign: pw.TextAlign.right,
            style: pw.TextStyle(font: ttf, fontSize: 13, height: 1.6),
          ),
        ],
      ),
    );
  }
  // Future<Uint8List> generatePdf() async {
  //   final pdf = pw.Document();
  //
  //   final imageBytes = await captureInvoice();
  //
  //   final image = pw.MemoryImage(imageBytes);
  //
  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: PdfPageFormat.a4,
  //       build: (context) {
  //         return pw.Image(image, fit: pw.BoxFit.contain);
  //       },
  //     ),
  //   );
  //
  //   return pdf.save();
  // }

  // Future<Uint8List> captureInvoice() async {
  //   await Future.delayed(const Duration(milliseconds: 200));
  //   RenderRepaintBoundary boundary =
  //       invoiceKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //
  //   final image = await boundary.toImage(pixelRatio: 3);
  //
  //   final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //
  //   return byteData!.buffer.asUint8List();
  // }
}
