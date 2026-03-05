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

  final double basicSalary; // المرتب الاساسي
  final double monthlySalary; // المرتب المجمع فى نهاية الشهر
  final double yearlySalary; // المرتب المجمع فى نهاية السنة

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
    required this.basicSalary,
    required this.monthlySalary,
    required this.yearlySalary,
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
      basicSalary: (json['basicSalary'] ?? 0).toDouble(),
      monthlySalary: (json['monthlySalary'] ?? 0).toDouble(),
      yearlySalary: (json['yearlySalary'] ?? 0).toDouble(),
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
      'basicSalary': basicSalary,
      'monthlySalary': monthlySalary,
      'yearlySalary': yearlySalary,
      'paymentMethod': paymentMethod.name,
      'weeklyAdvanceMethod': weeklyAdvanceMethod?.name,
      'weeklyAdvanceAmount': weeklyAdvanceAmount,
      'hireDate': hireDate.toIso8601String(),
      'isActive': isActive,
    };
  }

  EmployeeModel copyWith({
    String? id,
    String? name,
    String? nationalIDNumber,
    String? jobTitle,
    String? phone,
    String? acNo,
    double? basicSalary,
    double? monthlySalary,
    double? yearlySalary,
    PaymentMethod? paymentMethod,
    Object? weeklyAdvanceAmount = _noValue,
    Object? weeklyAdvanceMethod = _noValue,
    DateTime? hireDate,
    bool? isActive,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nationalIDNumber: nationalIDNumber ?? this.nationalIDNumber,
      jobTitle: jobTitle ?? this.jobTitle,
      phone: phone ?? this.phone,
      acNo: acNo ?? this.acNo,
      basicSalary: basicSalary ?? this.basicSalary,
      monthlySalary: monthlySalary ?? this.monthlySalary,
      yearlySalary: yearlySalary ?? this.yearlySalary,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      weeklyAdvanceAmount: weeklyAdvanceAmount == _noValue
          ? this.weeklyAdvanceAmount
          : weeklyAdvanceAmount as double?,
      weeklyAdvanceMethod: weeklyAdvanceMethod == _noValue
          ? this.weeklyAdvanceMethod
          : weeklyAdvanceMethod as WeeklyAdvanceMethod?,
      hireDate: hireDate ?? this.hireDate,
      isActive: isActive ?? this.isActive,
    );
  }

  static const _noValue = Object();
}
