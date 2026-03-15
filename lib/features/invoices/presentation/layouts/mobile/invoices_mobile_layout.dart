import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/core/constants/app_assets.dart';

import '../../../../../generated/l10n.dart';
import '../../manager/invoices_product/invoices_product_cubit.dart';
import '../../widgets/build_invoices_body.dart';

class InvoicesMobileLayout extends StatelessWidget {
  const InvoicesMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        title: Text(S.of(context).newInvoice),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 24),
            child: CircleAvatar(backgroundImage: AssetImage(AppAssets.logoImg)),
          ),
        ],
      ),
      body: BlocBuilder<InvoicesProductCubit, InvoicesProductState>(
        builder: (context, state) {
          if (state is InvoicesProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is InvoicesProductError) {
            return Center(child: Text(state.message));
          } else if (state is InvoicesProductSuccess) {
            final productsList = state.productsList;
            if (productsList.isEmpty) {
              return Center(child: Text(S.of(context).storeEmpty));
            }
            return BuildInvoicesBody(productsList: productsList);
          } else {
            return Center(child: Text(S.of(context).loading));
          }
        },
      ),
    );
  }
}
