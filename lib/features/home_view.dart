import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // الإحصائيات
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    title: 'إجمالي الإنتاج',
                    value: '153',
                    icon: Icons.shopping_bag,
                    color: Colors.red,
                  ),
                ),
                // const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: _buildStatCard(
                    title: 'نسبة الزيادة',
                    value: '+12%',
                    icon: Icons.trending_up,
                    color: AppColors.darkCard,
                  ),
                ),
              ],
            ),
            // const SizedBox(height: AppSpacing.xl),

            // الأقسام
            Text(
              'الأقسام',
              // style: AppTextStyles.heading3,
            ),
            // const SizedBox(height: AppSpacing.md),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              // mainAxisSpacing: AppSpacing.lg,
              // crossAxisSpacing: AppSpacing.lg,
              children: [
                _buildSectionCard(
                  title: 'المخزن الرئيسي',
                  subtitle: '450 صنف متنوع',
                  icon: Icons.warehouse,
                  onTap: () {
                    // setState(() => _currentIndex = 1);
                  },
                ),
                _buildSectionCard(
                  title: 'الفواتير',
                  subtitle: '12 فاتورة معلقة',
                  icon: Icons.receipt,
                  onTap: () {},
                ),
                _buildSectionCard(
                  title: 'حضور وانصراف',
                  subtitle: '85 موظف حاضر',
                  icon: Icons.people,
                  onTap: () {},
                ),
                _buildSectionCard(
                  title: 'التقارير',
                  subtitle: 'آخر التحديثات',
                  icon: Icons.bar_chart,
                  onTap: () {
                    // setState(() => _currentIndex = 3);
                  },
                ),
              ],
            ),
            // const SizedBox(height: AppSpacing.xl),

            // آخر التحديثات
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'آخر التحديثات',
                  // style: AppTextStyles.heading3
                ),
                TextButton(onPressed: () {}, child: const Text('عرض الكل')),
              ],
            ),
            // const SizedBox(height: AppSpacing.md),
            _buildUpdateItem('استيلام قياس جديد', 'منذ 30 دقيقة', Icons.shopping_cart),
            // const SizedBox(height: AppSpacing.md),
            _buildUpdateItem('تسجيل حضور صباحي', 'منذ ساعة', Icons.check_circle),
            // const SizedBox(height: AppSpacing.md),
            _buildUpdateItem('اعتماد فاتورة #9022', 'منذ ساعة', Icons.verified),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [AppShadows.md],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            // style: AppTextStyles.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          // boxShadow: [AppShadows.md],
          border: Border.all(color: Colors.transparent),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: AppColors.darkCard),
            // const SizedBox(height: AppSpacing.md),
            Text(
              title,
              // style: AppTextStyles.heading3,
              textAlign: TextAlign.center,
            ),
            // const SizedBox(height: AppSpacing.sm),
            Text(
              subtitle,
              // style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateItem(String title, String time, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [AppShadows.sm],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryRed, size: 24),
          // const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  // style: AppTextStyles.body1
                ),
                Text(
                  time,
                  // style: AppTextStyles.caption
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
