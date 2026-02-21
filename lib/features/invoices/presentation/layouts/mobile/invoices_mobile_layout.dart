import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/core/constants/app_assets.dart';

import '../../manager/invoices_cubit.dart';
import '../../widgets/build_invoices_body.dart';

class InvoicesMobileLayout extends StatelessWidget {
  const InvoicesMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        title: Text("فاتورة جديدة"),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 24),
            child: CircleAvatar(backgroundImage: AssetImage(AppAssets.logoImg)),
          ),
        ],
      ),
      body: BlocBuilder<InvoicesCubit, InvoicesState>(
        builder: (context, state) {
          if (state is InvoicesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is InvoicesError) {
            return Center(child: Text(state.message));
          } else if (state is InvoicesSuccess) {
            final productsList = state.productsList;
            if (productsList.isEmpty) {
              return const Center(child: Text("المخزن فارغ"));
            }
            return BuildInvoicesBody(productsList: productsList);
          } else {
            return const Center(child: Text("جار التحميل..."));
          }
        },
      ),
    );
  }
}
