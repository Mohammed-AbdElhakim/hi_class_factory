import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/extensions/context_extensions.dart';
import 'package:hi_class_factory/generated/l10n.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/firebase/firebase_service.dart';
import '../../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../auth/presentation/views/login_view.dart';
import '../../../../profile/presentation/views/profile_view.dart';
import '../../widgets/section_title.dart';
import '../../widgets/setting_tile.dart';

class SettingsMobileLayout extends StatefulWidget {
  const SettingsMobileLayout({super.key});

  @override
  State<SettingsMobileLayout> createState() => _SettingsMobileLayoutState();
}

class _SettingsMobileLayoutState extends State<SettingsMobileLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Color(0xff904A42),
        title: Text(
          S.of(context).settings,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ================= ACCOUNT SETTINGS =================
          SectionTitle(title: S.of(context).accountSettings),

          ///الملف الشخصي
          SettingTile(
            icon: Icons.person,
            title: S.of(context).profile,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileView()),
              );
            },
          ),

          // ================= APP SETTINGS =================
          SectionTitle(title: S.of(context).appPreferences),

          ///الاشعارات
          SettingTile(
            icon: Icons.notifications,
            title: S.of(context).notifications,
            trailingWidget: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                S.of(context).off,
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
            onTap: () {},
          ),

          ///اللغة
          SettingTile(
            icon: Icons.language,
            title: S.of(context).language,
            trailingWidget: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      if (!context.isEnglish) {
                        context.setLang(AppStrings.enLangKey);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.isEnglish ? Color(0xff904A42) : null,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Text(
                          "English",
                          style: TextStyle(
                            color: context.isEnglish ? Colors.white : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (!context.isArabic) {
                        context.setLang(AppStrings.arLangKey);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.isArabic ? Color(0xff904A42) : null,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Text(
                          "العربية",
                          style: TextStyle(color: context.isArabic ? Colors.white : null),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {},
          ),

          const SizedBox(height: 25),

          // ================= SECURITY =================
          // SectionTitle(title: S.of(context).securityAndSupport),

          ///الخصوصية والأمان
          // SettingTile(icon: Icons.security, title: S.of(context).privacyAndSecurity, onTap: () {}),

          ///الدعم الفني
          // SettingTile(icon: Icons.help_outline, title: S.of(context).technicalSupport, onTap: () {}),
          const SizedBox(height: 30),

          // ================= LOGOUT =================
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            onPressed: () {
              FirebaseService().logout();
              Pref.saveBoolToPref(key: AppStrings.isLoginKey, value: false);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginView()),
              );
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            label: Text(
              S.of(context).logout,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),

          const SizedBox(height: 20),

          Center(
            child: Text(S.of(context).companyName, style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
