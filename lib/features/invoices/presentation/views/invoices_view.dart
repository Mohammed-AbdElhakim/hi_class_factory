import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/core/responsive/adaptive_layout.dart';

import '../../../../core/constants/service_locator.dart';
import '../../data/repositories/invoices_repo_impl.dart';
import '../layouts/mobile/invoices_mobile_layout.dart';
import '../manager/invoices_product/invoices_product_cubit.dart';
import '../manager/save_invoices/save_invoices_cubit.dart';

class InvoicesView extends StatelessWidget {
  const InvoicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              InvoicesProductCubit(getIt.get<InvoicesRepoImpl>())..getProducts(),
        ),
        BlocProvider(
          create: (context) => SaveInvoicesCubit(getIt.get<InvoicesRepoImpl>()),
        ),
      ],
      child: AdaptiveLayout(
        mobilLayout: (context) => InvoicesMobileLayout(),
        tabletLayout: (context) => InvoicesMobileLayout(),
        desktopLayout: (context) => InvoicesMobileLayout(),
      ),
    );
  }
}
