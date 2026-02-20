import 'package:flutter/material.dart';

class Invoices extends StatelessWidget {
  const Invoices({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'فاتورة مبيعات',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: const Color(0xFF1A0A00),
      ),
      home: const SalesInvoicePage(),
    );
  }
}

// =============================================
// الصفحة الرئيسية للفاتورة
// =============================================
class SalesInvoicePage extends StatelessWidget {
  const SalesInvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: const [
                      _HeaderSection(),
                      _InvoiceTitleSection(),
                      _InvoiceMetaSection(),
                      _ClientSection(),
                      _ItemsTableSection(),
                      _NotesSection(),
                      _SignatureSection(),
                      _TotalSection(),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

// =============================================
// قسم رأس الصفحة: اسم الشركة، البيانات، الشعار
// =============================================
class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF1A0A00),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // بيانات المصنع
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'هاي كلاس',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Hi Class ',
                  style: TextStyle(
                    color: Color(0xFFCC0000),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                _InfoRow(icon: Icons.factory_outlined, text: 'مصنع ملابس جاهزة - جملة وقطاعي'),
                _InfoRow(icon: Icons.phone, text: '01006875972 | 01203483502'),
                _InfoRow(
                    icon: Icons.location_on,
                    text: 'طنامل الشرقى، أجا - الدقهلية '),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // لوجو المصنع
          Container(
            width: 100,
            height:80,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF2A1500),
            ),
            child: ClipOval(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Image.asset(
                  "assets/images/logo_img.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================
// ويدجت مساعد لعرض صف معلومات مع أيقونة
// =============================================
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Icon(icon, color: const Color(0xFFCC0000), size: 16),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================
// قسم عنوان الفاتورة وأزرار الطباعة والمشاركة
// =============================================
class _InvoiceTitleSection extends StatelessWidget {
  const _InvoiceTitleSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A1200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // العنوان والوصف
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                'فاتورة مبيعات',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'تفاصيل المعاملة المالية',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
          // أزرار الطباعة والمشاركة
          Row(
            children: [
              _IconButtonDark(icon: Icons.share_outlined, onTap: () {}),
              const SizedBox(width: 8),
              _IconButtonDark(icon: Icons.print_outlined, onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================
// ويدجت زر أيقونة بخلفية داكنة
// =============================================
class _IconButtonDark extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconButtonDark({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xFF3A1A00),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF5A2A00)),
        ),
        child: Icon(icon, color: Colors.white70, size: 20),
      ),
    );
  }
}

// =============================================
// قسم بيانات الفاتورة: رقم الفاتورة والتاريخ
// =============================================
class _InvoiceMetaSection extends StatelessWidget {
  const _InvoiceMetaSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _MetaCard(label: 'رقم الفاتورة', value: '#INV-2024-882'),
          const SizedBox(height: 10),
          _MetaCard(label: 'التاريخ', value: '2024/05/24'),
        ],
      ),
    );
  }
}

// =============================================
// كارت بيانات فاتورة (رقم الفاتورة / تاريخ) الكونتينر الاساسى
// =============================================
class _MetaCard extends StatelessWidget {
  final String label;
  final String value;

  const _MetaCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF2A1200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0xFFCC0000), fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================
// قسم بيانات العميل
// =============================================
class _ClientSection extends StatelessWidget {
  const _ClientSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF2A1200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            'اسم العميل',
            style: TextStyle(color: Color(0xFFCC0000), fontSize: 18),
          ),
          SizedBox(height: 6),
          Text(
            'محلات الحاج فلان ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================
// قسم جدول الأصناف والكميات والأسعار
// =============================================
class _ItemsTableSection extends StatelessWidget {
  const _ItemsTableSection();

  // بيانات الأصناف
  static const List<Map<String, dynamic>> items = [
    {
      'name': 'تيشرت قطن\nأوفر سايز - أسود',
      'qty': 50,
      'price': 250.00,
      'total': 12500.00,
    },
    {
      'name': 'بنطلون جينز سليم\nفيت - أزرق',
      'qty': 30,
      'price': 450.00,
      'total': 13500.00,
    },
    {
      'name': 'قميص كتان\nصيفي - أبيض',
      'qty': 20,
      'price': 380.00,
      'total': 7600.00,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF2A1200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // رأس الجدول والاساسى من هنا
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFF3A1800),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: const Row(
              textDirection: TextDirection.rtl,
              children: [
                Expanded(
                  flex: 3,
                  child: Text('الصنف',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color(0xFFCC0000),
                          fontWeight: FontWeight.bold,
                          fontSize: 13)),
                ),
                Expanded(
                  flex: 2,
                  child: Text('العدد',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFFCC0000),
                          fontWeight: FontWeight.bold,
                          fontSize: 13)),
                ),
                Expanded(
                  flex: 3,
                  child: Text('سعر الوحدة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFFCC0000),
                          fontWeight: FontWeight.bold,
                          fontSize: 13)),
                ),
                Expanded(
                  flex: 3,
                  child: Text('الإجمالي',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xFFCC0000),
                          fontWeight: FontWeight.bold,
                          fontSize: 13)),
                ),
              ],
            ),
          ),
          // صفوف الأصناف
          ...items.map((item) => _ItemRow(item: item)).toList(),
        ],
      ),
    );
  }
}

// =============================================
// صف صنف واحد في جدول الأصناف
// =============================================
class _ItemRow extends StatelessWidget {
  final Map<String, dynamic> item;

  const _ItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFF3A1800), width: 1),
        ),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // اسم الصنف
          Expanded(
            flex: 3,
            child: Text(
              item['name'],
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.5),
            ),
          ),
          // العدد
          Expanded(
            flex: 2,
            child: Text(
              '${item['qty']}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          // سعر الوحدة
          Expanded(
            flex: 3,
            child: Text(
              '${item['price'].toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          // الإجمالي
          Expanded(
            flex: 3,
            child: Text(
              '${_formatNumber(item['total'])}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(double n) {
    return n.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+\.)'),
          (m) => '${m[1]},',
    );
  }
}

// =============================================
// قسم الملاحظات وشروط الاستبدال
// =============================================
class _NotesSection extends StatelessWidget {
  const _NotesSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF2A1200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'ملاحظات',
            style: TextStyle(
                color: Color(0xFFCC0000),
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
          SizedBox(height: 8),
          Text(
            '- البضاعة المباعة لا ترد ولا تستبدل بعد 14 يوماً.',
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.6),
          ),
          Text(
            '- يجب إحضار أصل الفاتورة عند الاستبدال.',
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.6),
          ),
        ],
      ),
    );
  }
}

// =============================================
// قسم توقيع المستلم والمحاسب
// =============================================
class _SignatureSection extends StatelessWidget {
  const _SignatureSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF2A1200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _SignatureBox(label: 'توقيع المستلم'),
          _SignatureBox(label: 'توقيع المحاسب'),
        ],
      ),
    );
  }
}

// =============================================
// صندوق توقيع فردي الاساسى
// =============================================
class _SignatureBox extends StatelessWidget {
  final String label;

  const _SignatureBox({required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        const SizedBox(height: 8),
        Container(
          width: 130,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF5A2A00)),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ],
    );
  }
}

// =============================================
// قسم الإجمالي النهائي: الأصناف، الضريبة، الكلي
// =============================================
class _TotalSection extends StatelessWidget {
  const _TotalSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A1200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // إجمالي الأصناف
          _TotalRow(label: 'إجمالي الأصناف', value: '33,600.00'),
          const SizedBox(height: 8),
          // الضريبة
          _TotalRow(label: 'الضريبة (0%)', value: '0.00'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: Color(0xFF5A2A00)),
          ),
          // الإجمالي الكلي
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'الإجمالي الكلي',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '33,600.00 ج.م',
                style: TextStyle(
                  color: Color(0xFFCC0000),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // المبلغ كتابةً
          const Text(
            'فقط ثلاثة وثلاثون ألفاً وستمائة جنيهاً مصرياً لا غير',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// =============================================
// صف إجمالي مساعد (تسمية + قيمة)
// =============================================
class _TotalRow extends StatelessWidget {
  final String label;
  final String value;

  const _TotalRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 14)),
        Text(value,
            style: const TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }
}



