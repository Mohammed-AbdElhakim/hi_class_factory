import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/generated/l10n.dart';

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
        title: Text(
          S.of(context).invoiceArchive,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      // =================== BODY ===================
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<ReportCubit>().getReport();
        },
        child: BlocBuilder<ReportCubit, ReportState>(
          builder: (context, state) {
            if (state is ReportLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReportError) {
              return Center(child: Text(state.message));
            } else if (state is ReportSuccess) {
              final invoiceList = state.invoiceList;
              if (invoiceList.isEmpty) {
                return buildEmpty(context);
              }
              return buildInvoiceList(context, invoiceList);
            } else {
              return Center(child: Text(S.of(context).loading));
            }
          },
        ),
      ),
    );
  }

  Widget buildInvoiceList(BuildContext context, List<dynamic> invoiceList) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: invoiceList.length + 1, // +1 للرأسية (TOTAL + BUTTON)
      itemBuilder: (context, index) {
        if (index == 0) {
          // ROW TOTAL + BUTTON
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${S.of(context).totalInvoices}: ${invoiceList.length} ${S.of(context).invoices}",
                  style: const TextStyle(color: Colors.grey),
                ),
                buildElevatedButtonToAddNew(context),
              ],
            ),
          );
        }
        final invoice = invoiceList[index - 1];
        return InvoiceCard(invoice: invoice);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }

  ElevatedButton buildElevatedButtonToAddNew(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => InvoicesView()));
      },
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(S.of(context).addNew, style: TextStyle(color: Colors.white)),
    );
  }

  Widget buildEmpty(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        SizedBox(height: 100),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(S.of(context).noInvoices, style: TextStyle(fontSize: 18)),
              const SizedBox(height: 24),
              buildElevatedButtonToAddNew(context),
            ],
          ),
        ),
      ],
    );
  }
}
