import 'package:flutter/material.dart';

class SittingView extends StatelessWidget {
  const SittingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),

        body: SafeArea(
          child: Column(
            children: [

              // ================= HEADER =================
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 18),
                color: Colors.white,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "الإعدادات",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [

                    // ================= PROFILE =================
                    Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFE8D2A8),
                                border: Border.all(
                                  color: Colors.red.withOpacity(0.2),
                                  width: 4,
                                ),
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 18,
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          "الحاج وائل عبدالمنعم",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          "مدير المصنع",
                          style: TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          "Hi Class Factory",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // ================= ACCOUNT SETTINGS =================
                    const SectionTitle(title: "إعدادات الحساب"),

                    SettingTile(
                      icon: Icons.person,
                      title: "المعلومات الشخصية",
                    ),
                    SettingTile(
                      icon: Icons.lock,
                      title: "تغيير كلمة المرور",
                    ),

                    const SizedBox(height: 25),

                    // ================= APP SETTINGS =================
                    const SectionTitle(title: "تفضيلات التطبيق"),

                    SettingTile(
                      icon: Icons.notifications,
                      title: "الإشعارات",
                      trailingWidget: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "مفعل",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 12),
                        ),
                      ),
                    ),

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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Text("English"),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Text(
                                "العربية",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ================= SECURITY =================
                    const SectionTitle(title: "الأمان والدعم"),

                    SettingTile(
                      icon: Icons.security,
                      title: "الخصوصية والأمان",
                    ),
                    SettingTile(
                      icon: Icons.help_outline,
                      title: "الدعم الفني",
                    ),

                    const SizedBox(height: 30),

                    // ================= LOGOUT =================
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.logout,
                          color: Colors.white),
                      label: const Text(
                        "تسجيل الخروج",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Center(
                      child: Text(
                        "HI CLASS FACTORY ",
                        style: TextStyle(
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}

// ================= SECTION TITLE =================

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}

// ================= SETTING TILE =================

class SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailingWidget;

  const SettingTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black54),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          trailingWidget ??
              const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}