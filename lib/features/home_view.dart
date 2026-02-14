import 'package:flutter/material.dart';

import 'Attendance.dart';
import 'Invoices.dart';
import 'Salaries.dart';
import 'Warehouses.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: const [
              SizedBox(height: 10),
              Header(),
              SizedBox(height: 20),
              ProductionCard(),
              SizedBox(height: 20),
              GridSection(),
              SizedBox(height: 20),
              UpdatesSection(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// Header / appbar
////////////////////////////////////////////////////////////

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(radius:27 , backgroundImage: AssetImage("assets/images/logo_img.png"),),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              "هاي كلاس",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("نظام إدارة المصنع"),
          ],
        ),
        const Spacer(),
        const CircleAvatar(child: Icon(Icons.person)),
        const SizedBox(width: 10),
        const CircleAvatar(child: Icon(Icons.notifications)),

      ],
    );
  }
}

////////////////////////////////////////////////////////////
/// Production Card
////////////////////////////////////////////////////////////

class ProductionCard extends StatelessWidget {
  const ProductionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [
            Colors.black,
            Color(0xff3A1C1C),
          ],
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(.2),
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            "إجمالي الإنتاج اليومي",
            style: TextStyle(color: Colors.white70, fontSize: 20 , fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "1,280",
                style: TextStyle(
                  fontSize: 34,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Text(
                "قطعة",
                style: TextStyle(color: Colors.amber, fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// Grid Section / هنا الاستدعاء فقط اما الاساسى تحت
////////////////////////////////////////////////////////////

class GridSection extends StatelessWidget {
  const GridSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      childAspectRatio: 1.1,
      children: const [
        DashboardCard(
          icon: Icons.inventory_2,
          title: "المخزن الرئيسي",
          subtitle: "450 صنف متوفر",
          status: "",
          page: Warehouses(),
        ),
        DashboardCard(
          icon: Icons.receipt_long,
          title: "الفواتير",
          subtitle: "12 فاتورة معلقة",
          status: "",
          statusColor: Colors.orange,
          page: Invoices(),
        ),
        DashboardCard(
          icon: Icons.badge,
          title: "حضور وانصراف",
          subtitle: "85 موظف حاضر",
          status: "",
          page: Attendance(),
        ),
        DashboardCard(
          icon: Icons.payments,
          title: "الرواتب",
          subtitle: "تجهيز كشوف الشهر",
          status: "",
          statusColor: Colors.green,
          page: Salaries(),
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////
/// Dashboard Card / هنا الاساسى اللى بنستدعى منه فوق
////////////////////////////////////////////////////////////
class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String status;
  final Color? statusColor;
  final Widget page;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status,
    this.statusColor,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => page,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(.05),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey.shade200,
              child: Icon(icon),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey),
            ),
            if (status.isNotEmpty)
              Text(
                status,
                style: TextStyle(
                  color: statusColor ?? Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}


////////////////////////////////////////////////////////////
/// Updates Section / اخر التحديثات
////////////////////////////////////////////////////////////

// الاستدعاء فقط اما الاساسى تحت

class UpdatesSection extends StatelessWidget {
  const UpdatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "آخر التحديثات",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        UpdateTile(
          title: "استلام قماش قطني",
          subtitle: "تم إضافة 50 رول للمخزن",
          time: "منذ 5 د",
        ),
        UpdateTile(
          title: "تسجيل حضور صباحي",
          subtitle: "تم اكتمال حضور وردية الصباح",
          time: "منذ 25 د",
        ),
        UpdateTile(
          title: "اعتماد فاتورة #9022",
          subtitle: "بواسطة الإدارة المالية",
          time: "منذ ساعة",
        ),
      ],
    );
  }
}

// هنا الاساسى اللى بنستدعى منه فوق
class UpdateTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;

  const UpdateTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: const Icon(Icons.check_circle_outline),
      title: Text(title, textAlign: TextAlign.right),
      subtitle: Text(subtitle, textAlign: TextAlign.right),
      trailing: Text(time),
    );
  }
}

