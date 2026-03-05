import '../../../attendance/data/models/attendance_record_model.dart';
import '../../../employee/data/models/employee_model.dart';
import 'salary_result.dart';

class SalaryCalculator {
  final double basicSalary; // الراتب الأساسي
  final EmployeeModel employee;
  // final int workingDays; // أيام العمل في الشهر

  SalaryCalculator({required this.basicSalary, required this.employee});

  SalaryResult calculateSalary({required List<AttendanceRecordModel> records}) {
    // 1.مرتب الاسبوع الواحد
    double salaryWeek = basicSalary / 4;
    // 2. قيمة اليوم الواحد
    double dayValue = salaryWeek / 7;
    // double dayValue = basicSalary / workingDays;

    // 3. قيمة الساعة
    double hourValue = dayValue / 12;

    // 4. سعر ساعة الإضافي (150%)
    double otHourRate = hourValue * 1.5;

    // 5. حساب الإجماليات من البيانات
    double totalDays = 0;
    double totalAbsentDays = 0;
    Duration totalLate = Duration.zero;
    Duration totalOvertime = Duration.zero;

    for (var record in records) {
      // أيام الحضور
      totalDays += record.nDays!;

      // أيام الغياب
      totalAbsentDays += record.absent == "True" ? 1 : 0;

      // جمع التأخير
      totalLate += _parseDuration(record.late);

      // جمع الأوفر تايم
      totalOvertime += _parseDuration(record.otTime);
    }

    // 6. المرتب الأساسي حسب الحضور
    double grossSalary = totalDays * dayValue;

    // 7. الاضافي
    double overtimeAmount = (totalOvertime.inMinutes / 60) * otHourRate;

    // 8. خصم التأخير
    double lateDeduction = (totalLate.inMinutes / 60) * hourValue;

    // 9. خصم الغياب
    double absentDeduction = totalAbsentDays * dayValue;

    // 10. المرتب بعد الخصم والاضافة
    double totalSalary = grossSalary + overtimeAmount - lateDeduction - absentDeduction;

    // 11. المرتب النهائي
    double finalSalary = calculatorFinalSalary(totalSalary: totalSalary);

    // 12. الباقى الشهرى
    double monthly = calculatorMonthlySalary(
      monthlySalary: employee.monthlySalary,
      totalSalary: totalSalary,
    );
    // 13. الباقى السنوي
    double yearly = calculatorYearlySalary(
      yearlySalary: employee.yearlySalary,
      finalSalary: finalSalary,
    );

    //  إرجاع النتيجة كاملة
    return SalaryResult(
      basicSalary: basicSalary,
      salaryWeek: salaryWeek,
      totalSalary: totalSalary,
      yearlySalary: monthly,
      monthlySalary: yearly,
      finalSalary: finalSalary,
      totalAbsentDays: totalAbsentDays,
      absentDeduction: absentDeduction,
      totalLate: totalLate,
      lateDeduction: lateDeduction,
      totalOvertime: totalOvertime,
      overtimeAmount: overtimeAmount,
      totalWorkedDays: totalDays,
      grossSalary: grossSalary,
    );
  }

  // دالة مساعدة عشان تحول String لـ Duration
  Duration _parseDuration(String? durationString) {
    if (durationString == null || durationString.isEmpty) {
      return Duration.zero;
    }

    // لو الصيغة "HH:MM:SS" زي "03:52:00"
    try {
      var parts = durationString.split(':');
      if (parts.length >= 2) {
        int hours = int.parse(parts[0]);
        int minutes = parts.length > 1 ? int.parse(parts[1]) : 0;
        int seconds = parts.length > 2 ? int.parse(parts[2]) : 0;

        return Duration(hours: hours, minutes: minutes, seconds: seconds);
      }
    } catch (e) {
      return Duration.zero;
    }

    return Duration.zero;
  }

  double calculatorFinalSalary({required double totalSalary}) {
    switch (employee.paymentMethod) {
      case PaymentMethod.weekly:
        return totalSalary;
      case PaymentMethod.weeklyAdvance:
        return (totalSalary - employee.weeklyAdvanceAmount!) < 0
            ? totalSalary
            : totalSalary - employee.weeklyAdvanceAmount!;
      case PaymentMethod.monthly:
        return 0;
    }
  }

  double calculatorMonthlySalary({
    required double monthlySalary,
    required double totalSalary,
  }) {
    switch (employee.paymentMethod) {
      case PaymentMethod.weekly:
        return monthlySalary;
      case PaymentMethod.weeklyAdvance:
        final finalSalary = totalSalary - employee.weeklyAdvanceAmount!;
        double receiver = finalSalary < 0
            ? 0
            : employee.weeklyAdvanceAmount! - finalSalary;
        return monthlySalary + receiver;
      case PaymentMethod.monthly:
        return monthlySalary;
    }
  }

  double calculatorYearlySalary({
    required double yearlySalary,
    required double finalSalary,
  }) {
    switch (employee.paymentMethod) {
      case PaymentMethod.weekly:
        return yearlySalary;
      case PaymentMethod.weeklyAdvance:
        double many = employee.weeklyAdvanceAmount! - finalSalary;
        return yearlySalary + many;
      case PaymentMethod.monthly:
        return yearlySalary;
    }
  }

  bool isLastWeekOfMonth() {
    DateTime date = DateTime.now();
    final nextWeek = date.add(const Duration(days: 7));
    return nextWeek.month != date.month;
  }

  bool isLastWeekOfYear() {
    DateTime date = DateTime.now();
    final nextWeek = date.add(const Duration(days: 7));
    return nextWeek.year != date.year;
  }
}
