import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../invoices/presentation/views/invoices_view.dart';
import '../../manager/report_cubit.dart';
import '../../widgets/invoice_card.dart';

class ReportMobileLayout extends StatelessWidget {
  const ReportMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Color(0xff904A42),
        title: const Text(
          "أرشيف الفواتير",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
      ),
      // =================== BODY ===================
      body: BlocBuilder<ReportCubit, ReportState>(
        builder: (context, state) {
          if (state is ReportLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReportError) {
            return Center(child: Text(state.message));
          } else if (state is ReportSuccess) {
            final invoiceList = state.invoiceList;
            if (invoiceList.isEmpty) {
              return const Center(child: Text("لا يوجد فواتير"));
            }
            return Column(
              children: [
                // =================== TOTAL ===================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text("تصفية", style: TextStyle(color: Colors.grey)),
                      Text(
                        "إجمالي الفواتير: ${invoiceList.length} فاتورة",
                        style: TextStyle(color: Colors.grey),
                      ),
                      // زر إضافة جديد
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => InvoicesView()),
                          );
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          "إضافة جديد",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                // =================== LIST ===================
                Expanded(
                  child: ListView.separated(
                    itemCount: invoiceList.length,
                    itemBuilder: (context, index) =>
                        InvoiceCard(invoice: invoiceList[index]),
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("جار التحميل..."));
          }
        },
      ),
    );
  }
}
