import 'package:flutter/material.dart';

import '../../../accessories/presentation/views/accessories_view.dart';
import '../../../bakr/presentation/views/bakr_view.dart';
import '../../../fabric_details_view.dart';
import '../../../finishedProducts/presentation/views/finished_products_view.dart';

class Warehouses extends StatelessWidget {
  const Warehouses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(title: const Text("المخزن الرئيسي"), centerTitle: true),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ////////////////////////////////////////////////////////////
          // هنا البستدعى من الاساسى
          ///////////////////////////////////////////////////////////
          WarehouseCard(
            title: "مخزن المنتج النهائي",
            subtitle: "البضاعة الجاهزة للشحن",
            count: "1,250 قطعة",
            icon: Icons.checkroom,
            color: Colors.red,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FinishedProductsView()),
              );
            },
          ),

          const SizedBox(height: 20),

          WarehouseCard(
            title: "مخزن البكر",
            subtitle: "الخيوط وبكر التطريز",
            count: "840 كجم",
            icon: Icons.cyclone,
            color: Colors.orange,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BakrView()),
              );
            },
          ),

          const SizedBox(height: 20),

          WarehouseCard(
            title: "مخزن الأقمشة",
            subtitle: "جميع أنواع القماش",
            count: "5,200 متر",
            icon: Icons.grid_on,
            color: Colors.blue,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FabricDetailsView()),
              );
            },
          ),

          const SizedBox(height: 20),

          WarehouseCard(
            title: "مخزن الاكسسوارات",
            subtitle: "أزرار وسحابات",
            count: "12,000 قطعة",
            icon: Icons.widgets,
            color: Colors.deepPurple,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AccessoriesView()),
              );
            },
          ),
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////
// الاساسى
//////////////////////////////////////////////////////////////
class WarehouseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String count;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const WarehouseCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.count,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),

      //  دا بيخليه قابل للضغط
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,

        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              /// icon
              Container(
                height: 100,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color),
              ),

              const SizedBox(width: 20),

              /// text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(subtitle, style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 6),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: .15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        count,
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(Icons.arrow_forward_ios, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}
