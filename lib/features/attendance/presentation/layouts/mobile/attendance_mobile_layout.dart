import 'package:flutter/material.dart';

import '../../../data/models/attendance_record_model.dart';
import '../../views/save_excel_view.dart';

class AttendanceMobileLayout extends StatefulWidget {
  const AttendanceMobileLayout({super.key});

  @override
  State<AttendanceMobileLayout> createState() => _AttendanceMobileLayoutState();
}

class _AttendanceMobileLayoutState extends State<AttendanceMobileLayout> {
  List<AttendanceRecordModel> attendanceList = [];
  bool isLoading = false; // 🔹 هنا متغير اللودينج

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        title: const Text("الحضور والانصراف"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SaveExcelView()),
              );
            },
            icon: Icon(Icons.add),
          ),
          SizedBox(width: 20),
        ],
      ),

      body: Center(child: Text("الحضور والانصراف")),
    );
  }
}
