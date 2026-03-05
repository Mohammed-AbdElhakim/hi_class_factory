class SalaryResult {
  final double basicSalary; // الراتب الأساسي
  final double salaryWeek; // مرتب الاسبوع الواحد
  final double totalSalary; // المرتب بعد الخصم والاضافة
  final double finalSalary; //  المرتب النهائي بعد الحسابات حس طريقة قبض كل موظف
  final double yearlySalary;
  final double monthlySalary;
  // ✅ الغياب
  final double totalAbsentDays; // عدد أيام الغياب
  final double absentDeduction; // قيمة خصم الغياب

  // ✅ التأخير
  final Duration totalLate; // إجمالي وقت التأخير
  final double lateDeduction; // قيمة خصم التأخير

  // ✅ الأوفر تايم
  final Duration totalOvertime; // إجمالي وقت الإضافي
  final double overtimeAmount; // قيمة مبلغ الإضافي

  // ✅ تفاصيل تانية
  final double totalWorkedDays; // إجمالي أيام الحضور
  final double grossSalary; // المرتب قبل الخصومات

  SalaryResult._({
    required this.basicSalary,
    required this.salaryWeek,
    required this.totalSalary,
    required this.finalSalary,
    required this.monthlySalary,
    required this.yearlySalary,
    required this.totalAbsentDays,
    required this.absentDeduction,
    required this.totalLate,
    required this.lateDeduction,
    required this.totalOvertime,
    required this.overtimeAmount,
    required this.totalWorkedDays,
    required this.grossSalary,
  });
  // ✅ Factory Constructor اللي  هتستخدمه (بيقرب أوتوماتيك)
  factory SalaryResult({
    required double basicSalary,
    required double salaryWeek,
    required double totalSalary,
    required double finalSalary,
    required double monthlySalary,
    required double yearlySalary,
    required double totalAbsentDays,
    required double absentDeduction,
    required Duration totalLate,
    required double lateDeduction,
    required Duration totalOvertime,
    required double overtimeAmount,
    required double totalWorkedDays,
    required double grossSalary,
  }) {
    return SalaryResult._(
      basicSalary: _roundMoney(basicSalary),
      salaryWeek: _roundMoney(salaryWeek),
      totalSalary: _roundMoney(totalSalary),
      finalSalary: _roundMoney(finalSalary),
      monthlySalary: _roundMoney(monthlySalary),
      yearlySalary: _roundMoney(yearlySalary),
      totalAbsentDays: _roundDays(totalAbsentDays),
      absentDeduction: _roundMoney(absentDeduction),
      totalLate: totalLate, // Duration زي ما هو
      lateDeduction: _roundMoney(lateDeduction),
      totalOvertime: totalOvertime, // Duration زي ما هو
      overtimeAmount: _roundMoney(overtimeAmount),
      totalWorkedDays: _roundDays(totalWorkedDays),
      grossSalary: _roundMoney(grossSalary),
    );
  }
  factory SalaryResult.fromJson(Map<String, dynamic> json) {
    return SalaryResult(
      basicSalary: (json['basicSalary'] as num?)?.toDouble() ?? 0.0,
      salaryWeek: (json['salaryWeek'] as num?)?.toDouble() ?? 0.0,
      totalSalary: (json['totalSalary'] as num?)?.toDouble() ?? 0.0,
      finalSalary: (json['finalSalary'] as num?)?.toDouble() ?? 0.0,
      monthlySalary: (json['monthlySalary'] as num?)?.toDouble() ?? 0.0,
      yearlySalary: (json['yearlySalary'] as num?)?.toDouble() ?? 0.0,
      totalAbsentDays: (json['totalAbsentDays'] as num?)?.toDouble() ?? 0.0,
      absentDeduction: (json['absentDeduction'] as num?)?.toDouble() ?? 0.0,
      totalLate: Duration(milliseconds: json['totalLate'] ?? 0),
      lateDeduction: (json['lateDeduction'] as num?)?.toDouble() ?? 0.0,
      totalOvertime: Duration(milliseconds: json['totalOvertime'] ?? 0),
      overtimeAmount: (json['overtimeAmount'] as num?)?.toDouble() ?? 0.0,
      totalWorkedDays: (json['totalWorkedDays'] as num?)?.toDouble() ?? 0.0,
      grossSalary: (json['grossSalary'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'basicSalary': basicSalary,
      'salaryWeek': salaryWeek,
      'totalSalary': totalSalary,
      'finalSalary': finalSalary,
      'monthlySalary': monthlySalary,
      'yearlySalary': yearlySalary,
      'totalAbsentDays': totalAbsentDays,
      'absentDeduction': absentDeduction,
      'totalLate': totalLate.inMilliseconds,
      'lateDeduction': lateDeduction,
      'totalOvertime': totalOvertime.inMilliseconds,
      'overtimeAmount': overtimeAmount,
      'totalWorkedDays': totalWorkedDays,
      'grossSalary': grossSalary,
    };
  }

  // ✅ دالة مساعدة لعرض الوقت بشكل مقروء (ساعات:دقائق)
  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    return '$hoursس و $minutesد';
  }

  static double _roundMoney(double value) {
    return double.parse(value.toStringAsFixed(2));
  }

  static double _roundDays(double value) {
    return double.parse(value.toStringAsFixed(2));
  }
}
