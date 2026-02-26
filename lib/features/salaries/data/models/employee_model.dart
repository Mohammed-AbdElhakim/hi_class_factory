import 'package:hi_class_factory/core/constants/app_assets.dart';

class EmployeeModel {
  final String id;
  final String name;
  final String position;
  final double salary;
  final String photo;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.position,
    required this.salary,
    required this.photo,
  });

  // Factory constructor for JSON deserialization
  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      position: json['position'] ?? '',
      salary: _parseSalary(json['salary']),
      photo: json['photo'] ?? AppAssets.avatar,
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'salary': salary.toString(),
      'photo': photo,
    };
  }

  // Helper method to parse salary (handles both String and num)
  static double _parseSalary(dynamic salary) {
    if (salary is double) return salary;
    if (salary is int) return salary.toDouble();
    if (salary is String) {
      // Remove commas and parse
      return double.tryParse(salary.replaceAll(',', '')) ?? 0.0;
    }
    return 0.0;
  }

  // Copy with method for immutability
  EmployeeModel copyWith({
    String? id,
    String? name,
    String? position,
    double? salary,
    String? photo,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      salary: salary ?? this.salary,
      photo: photo ?? this.photo,
    );
  }

  // Formatted salary with currency
  String get formattedSalary {
    return '${salary.toStringAsFixed(2)} ج.م';
  }

  // Formatted salary with commas
  String get formattedSalaryWithCommas {
    return salary.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  @override
  String toString() {
    return 'EmployeeModel(id: $id, name: $name, position: $position, salary: $salary)';
  }
}
