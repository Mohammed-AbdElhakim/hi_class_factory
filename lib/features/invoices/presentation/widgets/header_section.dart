import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/constants/app_assets.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../profile/data/models/profile_model.dart';
import 'info_row.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  ProfileModel? profileData;
  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // بيانات المصنع
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 30),
                Text(
                  profileData?.name ?? "",
                  style: TextStyle(
                    color: Color(0xFFCC0000),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                InfoRow(
                  icon: Icons.factory_outlined,
                  text: profileData?.description ?? "l",
                ),
                InfoRow(
                  icon: Icons.phone,
                  text: '${profileData?.phone1} | ${profileData?.phone2}',
                ),
                InfoRow(icon: Icons.location_on, text: profileData?.address ?? "l"),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // لوجو المصنع
          Container(
            width: 100,
            height: 80,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF2A1500),
            ),
            child: ClipOval(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Image.asset(AppAssets.logoImg, fit: BoxFit.contain),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<ProfileModel?> getData() async {
    final data = await Pref.getStringFromPref(key: AppStrings.profileDataKey);
    if (data == null) {
      return null;
    }

    return ProfileModel.fromJson(jsonDecode(data) as Map<String, dynamic>);
  }

  void _loadProfile() async {
    final profile = await getData();

    if (!mounted) return;

    setState(() {
      profileData = profile;
    });
  }
}
