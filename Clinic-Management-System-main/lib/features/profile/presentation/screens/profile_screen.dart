import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/dependency_injection/di.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/profile_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>()..add(const ProfileEvent.fetchProfile()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const LoadingWidget(),
              error: (msg) => ErrorView(
                errorMessage: msg,
                onRetry: () => context.read<ProfileBloc>().add(const ProfileEvent.fetchProfile()),
              ),
              loaded: (profile) => ProfileInfo(profile: profile),
            );
          },
        ),
      ),
    );
  }
}
