import 'package:cloud_firestore/cloud_firestore.dart';

class PayrollModel {
  final String employeeId;
  final DateTime fromDate;
  final DateTime toDate;

  final double weeklyBase;
  final double absenceDeduction;
  final double lateDeduction;
  final double overtimeAmount;
  final double productionBonus;

  final double netSalary;

  final bool isApproved;
  final bool isPaid;

  final DateTime createdAt;

  PayrollModel({
    required this.employeeId,
    required this.fromDate,
    required this.toDate,
    required this.weeklyBase,
    required this.absenceDeduction,
    required this.lateDeduction,
    required this.overtimeAmount,
    required this.productionBonus,
    required this.netSalary,
    required this.isApproved,
    required this.isPaid,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'fromDate': Timestamp.fromDate(fromDate),
      'toDate': Timestamp.fromDate(toDate),
      'createdAt': Timestamp.fromDate(createdAt),
      'weeklyBase': weeklyBase,
      'absenceDeduction': absenceDeduction,
      'lateDeduction': lateDeduction,
      'overtimeAmount': overtimeAmount,
      'productionBonus': productionBonus,
      'netSalary': netSalary,
      'isApproved': isApproved,
      'isPaid': isPaid,
    };
  }
}
