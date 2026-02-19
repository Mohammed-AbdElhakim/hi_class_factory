import 'package:flutter/material.dart';

/////////////////
//  Model الموظف
////////////////
class EmployeeModel {
  final String name;
  final String jobTitle;
  final String phone;
  final int absentDays;
  final int lateDays;
  final int workStops;

  EmployeeModel({
    required this.name,
    required this.jobTitle,
    required this.phone,
    required this.absentDays,
    required this.lateDays,
    required this.workStops,
  });
}

class EmployeeView extends StatefulWidget {
  const EmployeeView({super.key});

  @override
  State<EmployeeView> createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView> {

  ////////////////////
  //  ليست الموظفين
  ///////////////////
  List<EmployeeModel> employees = [
    EmployeeModel(
      name: "أحمد على ",
      jobTitle: "عامل مكن كبير",
      phone: "01012345678",
      absentDays: 3,
      lateDays: 5,
      workStops: 1,
    ),
    EmployeeModel(
      name: "محمد سامى",
      jobTitle: "عامل ارضية",
      phone: "01198765432",
      absentDays: 1,
      lateDays: 2,
      workStops: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Color(0xff904A42),
        title: const Text("الموظفين" , style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 28),),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final employee = employees[index];

          return GestureDetector(
            onTap: () {
              _showEmployeeDetails(employee);
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Color(0xff904A42),
                      child: Text(
                        employee.name[0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          employee.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          employee.jobTitle,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showEmployeeDetails(EmployeeModel employee) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  employee.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff904A42),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _infoRow("الوظيفة", employee.jobTitle),
              _infoRow("رقم الهاتف", employee.phone),
              _infoRow("أيام الغياب", employee.absentDays.toString()),
              _infoRow("أيام التأخير", employee.lateDays.toString()),
              _infoRow("التوقف عن العمل", employee.workStops.toString()),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 15),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xff904A42),
              fontWeight: FontWeight.bold,
              fontSize: 15
            ),
          ),
        ],
      ),
    );
  }
}
