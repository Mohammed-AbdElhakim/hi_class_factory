import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/app_router.dart';
import '../../../../core/dependency_injection/di.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/home_bloc.dart';
import '../widgets/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeBloc>()..add(const HomeEvent.fetchData()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_rounded),
              onPressed: () => context.push(AppRouter.settings),
            ),
            IconButton(
              icon: const Icon(Icons.account_circle_rounded),
              onPressed: () => context.push(AppRouter.profile),
            ),
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const LoadingWidget(),
              error: (msg) => ErrorView(
                errorMessage: msg,
                onRetry: () => context.read<HomeBloc>().add(const HomeEvent.fetchData()),
              ),
              loaded: (data) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<HomeBloc>().add(const HomeEvent.fetchData());
                  },
                  child: ListView(
                    padding: const EdgeInsets.all(24.0),
                    children: [
                      HomeHeader(
                        totalBalance: data.totalBalance,
                        income: data.monthlyIncome,
                        expense: data.monthlyExpense,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Recent Transactions',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 12),
                      // TODO: Add dynamic transactions list builder
                      const Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.indigoAccent,
                            child: Icon(Icons.shopping_bag_outlined, color: Colors.white),
                          ),
                          title: Text('Grocery Shopping'),
                          subtitle: Text('Today, 10:30 AM'),
                          trailing: Text(
                            '-\$65.00',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
                          ),
                        ),
                      ),
                      const Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(Icons.attach_money_rounded, color: Colors.white),
                          ),
                          title: Text('Salary Payday'),
                          subtitle: Text('Yesterday, 6:00 PM'),
                          trailing: Text(
                            '+\$2,500.00',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
