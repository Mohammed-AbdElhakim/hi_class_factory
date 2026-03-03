class PayrollModel {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final double totalNet;
  final int employeesCount;

  PayrollModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.totalNet,
    required this.employeesCount,
  });

  factory PayrollModel.fromJson(String id, Map<String, dynamic> json) => PayrollModel(
    id: id,
    startDate: json['startDate'].toDate(),
    endDate: json['endDate'].toDate(),
    createdAt: json['createdAt'].toDate(),
    totalNet: (json['totalNet'] as num).toDouble(),
    employeesCount: json['employeesCount'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'startDate': startDate,
    'endDate': endDate,
    'createdAt': createdAt,
    'totalNet': totalNet,
    'employeesCount': employeesCount,
  };
}
