import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/service_locator.dart';
import '../../../../employee/data/repositories/employee_repo_impl.dart';
import '../../../../employee/presentation/manager/employee_cubit.dart';
import '../../../../employee/presentation/views/employee_view.dart';
import '../../../../home/presentation/views/home_view.dart';
import '../../../../report/presentation/views/report_view.dart';
import '../../../../sitting/presentation/views/sitting_view.dart';
import '../../widgets/custom_bottom_navigation_bar.dart';

class NavigationBarMobileLayout extends StatefulWidget {
  const NavigationBarMobileLayout({super.key});

  @override
  State<NavigationBarMobileLayout> createState() => _NavigationBarMobileLayoutState();
}

class _NavigationBarMobileLayoutState extends State<NavigationBarMobileLayout> {
  int currentIndexPage = 0;

  final List<Widget> _pages = [HomeView(), ReportView(), EmployeeView(), SittingView()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmployeeCubit(getIt.get<EmployeeRepoImpl>())..getEmployee(),
      child: Scaffold(
        body: _pages[currentIndexPage],
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndexPage: currentIndexPage,
          onTap: (value) {
            setState(() {
              currentIndexPage = value;
            });
          },
        ),
      ),
    );
  }
}
