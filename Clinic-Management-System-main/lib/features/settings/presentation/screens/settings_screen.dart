import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/dependency_injection/di.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/settings_bloc.dart';
import '../widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SettingsBloc>()..add(const SettingsEvent.loadSettings()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const LoadingWidget(),
              error: (msg) => ErrorView(
                errorMessage: msg,
                onRetry: () => context.read<SettingsBloc>().add(const SettingsEvent.loadSettings()),
              ),
              loaded: (settings) {
                return ListView(
                  padding: const EdgeInsets.all(24.0),
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SettingsTile(
                              icon: Icons.dark_mode_outlined,
                              title: 'Dark Mode',
                              trailing: Switch(
                                value: settings.isDarkMode,
                                onChanged: (value) {
                                  // TODO: Trigger dark mode update event
                                },
                              ),
                            ),
                            const Divider(),
                            SettingsTile(
                              icon: Icons.language_outlined,
                              title: 'Language',
                              trailing: DropdownButton<String>(
                                value: settings.languageCode,
                                underline: const SizedBox(),
                                items: const [
                                  DropdownMenuItem(value: 'en', child: Text('English')),
                                  DropdownMenuItem(value: 'ar', child: Text('العربية')),
                                ],
                                onChanged: (value) {
                                  // TODO: Trigger language update event
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
