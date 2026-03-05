import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/employee_model.dart';

class AddEmployeeBottomSheet extends StatefulWidget {
  const AddEmployeeBottomSheet({super.key, this.editEmployee});
  final EmployeeModel? editEmployee;

  @override
  State<AddEmployeeBottomSheet> createState() => _AddEmployeeBottomSheetState();
}

class _AddEmployeeBottomSheetState extends State<AddEmployeeBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final nationalIDNumberController = TextEditingController();
  final jobController = TextEditingController();
  final phoneController = TextEditingController();
  final acNoController = TextEditingController();
  final basicSalaryController = TextEditingController();
  final monthlySalaryController = TextEditingController();
  final yearlySalaryController = TextEditingController();
  PaymentMethod paymentMethod = PaymentMethod.weeklyAdvance;
  WeeklyAdvanceMethod weeklyAdvanceMethod = WeeklyAdvanceMethod.yearly;
  final weeklyAdvanceAmountController = TextEditingController();
  bool isActive = true;

  void _saveEmployee() {
    if (!_formKey.currentState!.validate()) return;

    final employee = EmployeeModel(
      id: widget.editEmployee?.id ?? "",
      name: nameController.text,
      nationalIDNumber: nationalIDNumberController.text,
      jobTitle: jobController.text,
      phone: phoneController.text,
      acNo: acNoController.text,
      basicSalary: double.parse(basicSalaryController.text.trim()),
      monthlySalary: double.parse(monthlySalaryController.text.trim()),
      yearlySalary: double.parse(yearlySalaryController.text.trim()),
      paymentMethod: paymentMethod,
      weeklyAdvanceAmount: paymentMethod == PaymentMethod.weeklyAdvance
          ? double.parse(weeklyAdvanceAmountController.text.trim())
          : 0,
      weeklyAdvanceMethod: paymentMethod == PaymentMethod.weeklyAdvance
          ? weeklyAdvanceMethod
          : WeeklyAdvanceMethod.yearly,
      isActive: isActive,
      hireDate: DateTime.now(),
    );

    Navigator.pop(context, employee);
  }

  @override
  void initState() {
    super.initState();
    if (widget.editEmployee != null) {
      nameController.text = widget.editEmployee!.name;
      nationalIDNumberController.text = widget.editEmployee!.nationalIDNumber;
      jobController.text = widget.editEmployee!.jobTitle;
      phoneController.text = widget.editEmployee!.phone;
      acNoController.text = widget.editEmployee!.acNo;
      monthlySalaryController.text = widget.editEmployee!.monthlySalary.toString();
      yearlySalaryController.text = widget.editEmployee!.yearlySalary.toString();
      basicSalaryController.text = widget.editEmployee!.basicSalary.toString();
      weeklyAdvanceAmountController.text =
          widget.editEmployee!.paymentMethod == PaymentMethod.weeklyAdvance
          ? widget.editEmployee!.weeklyAdvanceAmount.toString()
          : "";
      isActive = widget.editEmployee!.isActive;
      paymentMethod = widget.editEmployee!.paymentMethod;
      weeklyAdvanceMethod = widget.editEmployee!.weeklyAdvanceMethod!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: FractionallySizedBox(
        heightFactor: 0.8,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  widget.editEmployee == null ? "إضافة موظف جديد" : "تعديل بيانات موظف",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                /// name
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "اسم الموظف",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v!.isEmpty ? "مطلوب" : null,
                ),
                const SizedBox(height: 12),

                /// nationalIDNumber
                TextFormField(
                  controller: nationalIDNumberController,
                  decoration: const InputDecoration(
                    labelText: "الرقم القومي",
                    border: OutlineInputBorder(),
                  ),
                  validator: nationalIDValidator,
                ),
                const SizedBox(height: 12),

                ///acNo
                TextFormField(
                  controller: acNoController,
                  decoration: const InputDecoration(
                    labelText: "كود الموظف ",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v!.isEmpty ? "مطلوب" : null,
                ),
                const SizedBox(height: 12),

                /// job
                TextFormField(
                  controller: jobController,
                  decoration: const InputDecoration(
                    labelText: "الوظيفة",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v!.isEmpty ? "مطلوب" : null,
                ),
                const SizedBox(height: 12),

                /// phone
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: "رقم الهاتف",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: phoneValidator,
                ),
                const SizedBox(height: 12),

                /// basicSalary
                TextFormField(
                  controller: basicSalaryController,
                  decoration: const InputDecoration(
                    labelText: "المرتب الشهري",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) => v!.isEmpty ? "مطلوب" : null,
                ),
                const SizedBox(height: 12),

                /// monthlySalary
                TextFormField(
                  controller: monthlySalaryController,
                  decoration: const InputDecoration(
                    labelText: "الرصيد الشهري",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) => v!.isEmpty ? "مطلوب" : null,
                ),
                const SizedBox(height: 12),

                ///yearlySalary
                TextFormField(
                  controller: yearlySalaryController,
                  decoration: const InputDecoration(
                    labelText: "الرصيد السنوي",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) => v!.isEmpty ? "مطلوب" : null,
                ),
                const SizedBox(height: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("طريقة القبض"),
                    RadioGroup<PaymentMethod>(
                      onChanged: (value) {
                        setState(() {
                          paymentMethod = value!;
                        });
                      },
                      groupValue: paymentMethod,
                      child: Column(
                        children: [
                          RadioListTile<PaymentMethod>(
                            title: Text("قبض شهري"),
                            value: PaymentMethod.monthly,
                          ),
                          RadioListTile<PaymentMethod>(
                            title: Text("قبض اسبوعى كامل"),
                            value: PaymentMethod.weekly,
                          ),
                          RadioListTile<PaymentMethod>(
                            title: Text("سلفة أسبوعية"),
                            value: PaymentMethod.weeklyAdvance,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                if (paymentMethod == PaymentMethod.weeklyAdvance)
                  /// weeklyAdvanceAmount
                  TextFormField(
                    controller: weeklyAdvanceAmountController,
                    decoration: const InputDecoration(
                      labelText: "قيمة السلفة الأسبوعية",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        v!.isEmpty && paymentMethod == PaymentMethod.weeklyAdvance
                        ? "مطلوب"
                        : null,
                  ),
                if (paymentMethod == PaymentMethod.weeklyAdvance)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Text("الباقى من الراتب"),
                      RadioGroup<WeeklyAdvanceMethod>(
                        onChanged: (value) {
                          setState(() {
                            weeklyAdvanceMethod = value!;
                          });
                        },
                        groupValue: weeklyAdvanceMethod,
                        child: Row(
                          children: [
                            Expanded(
                              child: RadioListTile<WeeklyAdvanceMethod>(
                                title: Text("شهري"),
                                value: WeeklyAdvanceMethod.monthly,
                              ),
                            ),

                            Expanded(
                              child: RadioListTile<WeeklyAdvanceMethod>(
                                title: Text("سنوي"),
                                value: WeeklyAdvanceMethod.yearly,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("حالة الموظف"),
                    RadioGroup<bool>(
                      onChanged: (value) {
                        setState(() {
                          isActive = value!;
                        });
                      },
                      groupValue: isActive,
                      child: Column(
                        children: [
                          RadioListTile<bool>(title: Text("يعمل"), value: true),
                          RadioListTile<bool>(
                            title: Text("متوقف عن العمل"),
                            value: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: _saveEmployee,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkCard,
                    minimumSize: const Size(double.infinity, 35),
                  ),
                  child: Text(
                    widget.editEmployee == null ? "حفظ الموظف" : "تعديل الموظف",
                    style: TextStyle(color: AppColors.textWhite),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) return "مطلوب";

    if (!RegExp(r'^\d+$').hasMatch(value)) return "الرقم يجب أن يكون أرقام فقط";

    if (!RegExp(r'^(010|011|012|015)\d{8}$').hasMatch(value)) {
      return "رقم الموبايل غير صحيح";
    }

    return null;
  }

  String? nationalIDValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "مطلوب";
    }

    // التحقق من الطول والأرقام فقط
    if (value.length != 14 || !RegExp(r'^\d+$').hasMatch(value)) {
      return "الرقم القومي يجب أن يكون 14 رقم";
    }

    // التحقق من القرن (الرقم الأول)
    String firstDigit = value[0];
    if (firstDigit != '2' && firstDigit != '3') {
      return "الرقم القومي غير صالح";
    }

    // التحقق من تاريخ الميلاد
    int month = int.parse(value.substring(3, 5));
    int day = int.parse(value.substring(5, 7));
    if (month < 1 || month > 12) return "شهر الميلاد غير صحيح";
    if (day < 1 || day > 31) return "يوم الميلاد غير صحيح";

    return null; // كل شيء صحيح
  }
}
