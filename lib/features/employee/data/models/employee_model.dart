enum PaymentMethod {
  monthly, // يقبض مرة واحدة في الشهر
  weekly, // يقبض مرة كل اسبوع
  weeklyAdvance, // يقبض سلفة أسبوعية والباقي يتجمع
}

enum WeeklyAdvanceMethod { monthly, yearly }

class EmployeeModel {
  final String id;
  final String name;
  final String nationalIDNumber;
  final String jobTitle;
  final String phone;
  final String acNo;

  final double monthlySalary; // المرتب الشهري الحقيقي

  final PaymentMethod paymentMethod;

  final double? weeklyAdvanceAmount;
  // لو بياخد سلفة أسبوعية نحط المبلغ هنا
  // لو شهري عادي تبقى null
  final WeeklyAdvanceMethod? weeklyAdvanceMethod;
  // الباقى من القبض هيتم قبضه سنوى ول شهري
  final DateTime hireDate;
  final bool isActive;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.nationalIDNumber,
    required this.jobTitle,
    required this.phone,
    required this.acNo,
    required this.monthlySalary,
    required this.paymentMethod,
    this.weeklyAdvanceAmount,
    this.weeklyAdvanceMethod,
    required this.hireDate,
    required this.isActive,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      nationalIDNumber: json['nationalIDNumber'] ?? '',
      jobTitle: json['jobTitle'] ?? '',
      phone: json['phone'] ?? '',
      acNo: json['acNo'] ?? '',
      monthlySalary: (json['monthlySalary'] ?? 0).toDouble(),
      paymentMethod: PaymentMethod.values.firstWhere(
        (e) => e.name == json['paymentMethod'],
        orElse: () => PaymentMethod.monthly,
      ),
      weeklyAdvanceAmount: json['weeklyAdvanceAmount'] != null
          ? (json['weeklyAdvanceAmount']).toDouble()
          : null,
      weeklyAdvanceMethod: json['weeklyAdvanceMethod'] != null
          ? WeeklyAdvanceMethod.values.firstWhere(
              (e) => e.name == json['weeklyAdvanceMethod'],
              orElse: () => WeeklyAdvanceMethod.yearly,
            )
          : null,
      hireDate: DateTime.parse(json['hireDate']),
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nationalIDNumber': nationalIDNumber,
      'jobTitle': jobTitle,
      'phone': phone,
      'acNo': acNo,
      'monthlySalary': monthlySalary,
      'paymentMethod': paymentMethod.name,
      'weeklyAdvanceMethod': weeklyAdvanceMethod?.name,
      'weeklyAdvanceAmount': weeklyAdvanceAmount,
      'hireDate': hireDate.toIso8601String(),
      'isActive': isActive,
    };
  }
}
