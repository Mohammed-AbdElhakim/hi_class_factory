import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/profile.dart';

class ProfileInfo extends StatelessWidget {
  final Profile profile;

  const ProfileInfo({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.primary.withValues(alpha: 26),
                  backgroundImage: profile.profileImageUrl != null
                      ? NetworkImage(profile.profileImageUrl!)
                      : null,
                  child: profile.profileImageUrl == null
                      ? const Icon(Icons.person_rounded, size: 64, color: AppColors.primary)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.primary,
                    child: IconButton(
                      icon: const Icon(Icons.edit_rounded, size: 16, color: Colors.white),
                      onPressed: () {
                        // TODO: Implement image upload/edit
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.badge_outlined),
                    title: const Text('Name'),
                    subtitle: Text(profile.fullName),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.email_outlined),
                    title: const Text('Email'),
                    subtitle: Text(profile.email),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
