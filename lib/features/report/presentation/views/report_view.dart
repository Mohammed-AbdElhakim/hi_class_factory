import 'package:flutter/material.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),

        // =================== BODY ===================
        body: SafeArea(
          child: Column(
            children: [

              // =================== HEADER ===================
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // زر إضافة جديد
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        "إضافة جديد",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    const Row(
                      children: [
                        Icon(Icons.search, color: Colors.black54),
                        SizedBox(width: 10),
                        Text(
                          "أرشيف الفواتير",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    // لوجو
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color(0xFFB7B76A),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "HI\nCLASS",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // =================== TOTAL ===================
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "تصفية",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "إجمالي الفواتير: 48 فاتورة",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),

              // =================== LIST ===================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: const [

                    InvoiceCard(
                      status: "مدفوع",
                      statusColor: Colors.green,
                      number: "INV-2024-001#",
                      date: "24 أكتوبر 2024",
                      title: "متجر الأناقة الحديثة",
                      subtitle: "توريد أقمشة حرير ومخمل",
                      amount: "1,500",
                      amountColor: Colors.black,
                    ),

                    InvoiceCard(
                      status: "قيد الانتظار",
                      statusColor: Colors.orange,
                      number: "INV-2024-002#",
                      date: "22 أكتوبر 2024",
                      title: "مؤسسة فاشن لاين",
                      subtitle: "تصنيع ملابس شتوية - دفعة أولى",
                      amount: "3,750",
                      amountColor: Colors.red,
                    ),

                    InvoiceCard(
                      status: "متأخر",
                      statusColor: Colors.red,
                      number: "INV-2024-003#",
                      date: "18 أكتوبر 2024",
                      title: "بوتيك الكساء الفاخر",
                      subtitle: "بدلات رجالية رسمية - طلبية خاصة",
                      amount: "5,200",
                      amountColor: Colors.black,
                    ),

                    InvoiceCard(
                      status: "مدفوع",
                      statusColor: Colors.green,
                      number: "INV-2024-004#",
                      date: "15 أكتوبر 2024",
                      title: "شركة المنسوجات العالمية",
                      subtitle: "أدوات خياطة وخيوط متنوعة",
                      amount: "890",
                      amountColor: Colors.black,
                    ),

                    SizedBox(height: 20),

                    Center(
                      child: Text(
                        "عرض المزيد من الفواتير",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),

                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}

// =================== INVOICE CARD ===================

class InvoiceCard extends StatelessWidget {
  final String status;
  final Color statusColor;
  final String number;
  final String date;
  final String title;
  final String subtitle;
  final String amount;
  final Color amountColor;

  const InvoiceCard({
    super.key,
    required this.status,
    required this.statusColor,
    required this.number,
    required this.date,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.amountColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                number,
                style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            "تاريخ: $date",
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 5),

          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey),
          ),

          const Divider(height: 25),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ر.س $amount",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: amountColor),
              ),
              const Text(
                "القيمة الإجمالية",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}