import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/core/constants/app_assets.dart';
import 'package:hi_class_factory/core/constants/app_strings.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../data/models/profile_model.dart';
import '../../manager/profile_cubit.dart';
import '../../widgets/edit_profile_bottom_sheet.dart';
import '../../widgets/info_row.dart';

class ProfileMobileLayout extends StatefulWidget {
  const ProfileMobileLayout({super.key});

  @override
  State<ProfileMobileLayout> createState() => _ProfileMobileLayoutState();
}

class _ProfileMobileLayoutState extends State<ProfileMobileLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff904A42),
        title: const Text(
          "المف الشخصي",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
              child: Column(
                children: [
                  if (state is ProfileSuccess)
                    if (state.profile != null)
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: InkWell(
                          onTap: () {
                            editProfileSheet(state.profile);
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Color(0xff904A42),
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(12),
                              ),
                            ),
                            child: Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
                      ),
                  if (state is ProfileSuccess)
                    if (state.profile == null)
                      SizedBox(width: double.infinity, height: 24),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFE8D2A8),
                      border: Border.all(
                        color: Colors.red.withValues(alpha: 0.2),
                        width: 4,
                      ),
                    ),
                    child: Image.asset(AppAssets.logoImg),
                  ),

                  const SizedBox(height: 12),
                  Text(
                    AppStrings.factoryName,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),

                  /*Card(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "مدير المصنع",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),

                      Align(
                        alignment: Alignment.center,
                        child: const Text(
                          "الحاج وائل عبدالمنعم",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),*/
                  if (state is ProfileSuccess)
                    if (state.profile != null)
                      Card(
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 8,
                              left: 8,
                              bottom: 16,
                              top: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoRow(
                                  icon: Icons.factory_outlined,
                                  text: state.profile!.description,
                                ),
                                InfoRow(
                                  icon: Icons.phone,
                                  text:
                                      '${state.profile!.phone1}\n${state.profile!.phone2}',
                                ),
                                InfoRow(
                                  icon: Icons.location_on,
                                  text: state.profile!.address,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  if (state is ProfileSuccess)
                    if (state.profile == null)
                      ElevatedButton.icon(
                        onPressed: () {
                          editProfileSheet(null);
                        },
                        style: ElevatedButton.styleFrom(
                          shadowColor: AppColors.darkCard,
                          elevation: 5,
                          // backgroundColor: AppColors.darkCard.withValues(alpha: .5),
                        ),
                        icon: const Icon(Icons.add, size: 25),
                        label: Text(
                          "أدخل بيانات مصنعك",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                  if (state is ProfileError) Center(child: Text(state.message)),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void editProfileSheet(ProfileModel? profile) async {
    final result = await showModalBottomSheet<ProfileModel>(
      context: context,
      isScrollControlled: true,
      builder: (_) => EditProfileBottomSheet(editProfile: profile),
    );
    if (!mounted) return;
    if (result != null) {
      context.read<ProfileCubit>().saveProfile(result);
    }
  }
}
