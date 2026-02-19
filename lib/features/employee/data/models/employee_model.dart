class EmployeeModel {
  final String id;
  final String name;
  final String jobTitle;
  final String phone;
  final int absentDays;
  final int lateDays;
  final int workStops;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.jobTitle,
    required this.phone,
    required this.absentDays,
    required this.lateDays,
    required this.workStops,
  });

  /// Convert JSON to Model
  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      jobTitle: json['jobTitle'] ?? '',
      phone: json['phone'] ?? '',
      absentDays: json['absentDays'] ?? 0,
      lateDays: json['lateDays'] ?? 0,
      workStops: json['workStops'] ?? 0,
    );
  }

  /// Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'jobTitle': jobTitle,
      'phone': phone,
      'absentDays': absentDays,
      'lateDays': lateDays,
      'workStops': workStops,
    };
  }

  /// CopyWith (مهم لو بتستخدم Bloc أو Cubit)
  EmployeeModel copyWith({
    String? id,
    String? name,
    String? jobTitle,
    String? phone,
    int? absentDays,
    int? lateDays,
    int? workStops,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      jobTitle: jobTitle ?? this.jobTitle,
      phone: phone ?? this.phone,
      absentDays: absentDays ?? this.absentDays,
      lateDays: lateDays ?? this.lateDays,
      workStops: workStops ?? this.workStops,
    );
  }
}
