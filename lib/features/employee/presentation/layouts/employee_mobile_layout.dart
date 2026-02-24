import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/employee_model.dart';
import '../manager/employee_cubit.dart';
import '../widgets/add_employee_bottom_sheet.dart';
import '../widgets/employee_card.dart';
import '../widgets/employee_details_bottom_sheet.dart';

class EmployeeMobileLayout extends StatefulWidget {
  const EmployeeMobileLayout({super.key});

  @override
  State<EmployeeMobileLayout> createState() => _EmployeeMobileLayoutState();
}

class _EmployeeMobileLayoutState extends State<EmployeeMobileLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Color(0xff904A42),
        title: const Text(
          "الموظفين",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _openAddEmployeeSheet,
            icon: Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EmployeeError) {
            return Center(child: Text(state.message));
          } else if (state is EmployeeSuccess) {
            final employeeList = state.employee;
            if (employeeList.isEmpty) {
              return const Center(child: Text("لا يوجد موظفيين"));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: employeeList.length,
              itemBuilder: (context, index) {
                final employee = employeeList[index];
                final cubit = context.read<EmployeeCubit>();

                return GestureDetector(
                  onTap: () {
                    _showEmployeeDetails(employee);
                  },
                  child: EmployeeCard(
                    employee: employee,
                    onEdit: (employee) async {
                      final result = await showModalBottomSheet<EmployeeModel>(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) => AddEmployeeBottomSheet(editEmployee: employee),
                      );
                      if (result != null) {
                        cubit.updateEmployee(result);
                      }
                    },
                    onDelete: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("تأكيد الحذف"),
                          content: const Text("هل أنت متأكد أنك تريد حذف هذا الموظف؟"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text("إلغاء"),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text("حذف"),
                            ),
                          ],
                        ),
                      );
                      if (confirm == true) {
                        cubit.deleteEmployee(employeeList[index].id);
                      }
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("جار التحميل..."));
          }
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
        return EmployeeDetailsBottomSheet(employeeModel: employee);
      },
    );
  }

  void _openAddEmployeeSheet() async {
    final result = await showModalBottomSheet<EmployeeModel>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const AddEmployeeBottomSheet(),
    );
    if (!mounted) return;
    if (result != null) {
      context.read<EmployeeCubit>().addEmployee(result);
    }
  }
}
