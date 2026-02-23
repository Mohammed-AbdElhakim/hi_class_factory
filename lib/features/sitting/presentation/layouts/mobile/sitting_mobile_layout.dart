import 'package:flutter/material.dart';
import 'package:hi_class_factory/features/profile.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/firebase/firebase_service.dart';
import '../../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../auth/presentation/views/login_view.dart';
import '../../widgets/section_title.dart';
import '../../widgets/setting_tile.dart';

class SittingMobileLayout extends StatelessWidget {
  const SittingMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Color(0xff904A42),
        title: const Text(
          "الإعدادات",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ================= ACCOUNT SETTINGS =================
          const SectionTitle(title: "إعدادات الحساب"),

          ///الملف الشخصي
          SettingTile(
            icon: Icons.person,
            title: "الملف الشخصي",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),

          // ================= APP SETTINGS =================
          const SectionTitle(title: "تفضيلات التطبيق"),

          ///الاشعارات
          SettingTile(
            icon: Icons.notifications,
            title: "الإشعارات",
            trailingWidget: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "مفعل",
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
            onTap: () {},
          ),

          ///اللغة
          SettingTile(
            icon: Icons.language,
            title: "اللغة",
            trailingWidget: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Text("English"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Text("العربية", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            onTap: () {},
          ),

          const SizedBox(height: 25),

          // ================= SECURITY =================
          const SectionTitle(title: "الأمان والدعم"),

          ///الخصوصية والأمان
          SettingTile(icon: Icons.security, title: "الخصوصية والأمان", onTap: () {}),

          ///الدعم الفني
          SettingTile(icon: Icons.help_outline, title: "الدعم الفني", onTap: () {}),

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
            label: const Text(
              "تسجيل الخروج",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),

          const SizedBox(height: 20),

          const Center(
            child: Text("HI CLASS FACTORY ", style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
