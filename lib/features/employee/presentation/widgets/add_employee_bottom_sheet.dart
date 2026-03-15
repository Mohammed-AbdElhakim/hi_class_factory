import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../generated/l10n.dart';
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
                  widget.editEmployee == null
                      ? S.of(context).addNewEmployee
                      : S.of(context).editEmployee,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                /// name
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: S.of(context).employeeName,
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v!.isEmpty ? S.of(context).required : null,
                ),
                const SizedBox(height: 12),

                /// nationalIDNumber
                TextFormField(
                  controller: nationalIDNumberController,
                  decoration: InputDecoration(
                    labelText: S.of(context).nationalId,
                    border: OutlineInputBorder(),
                  ),
                  validator: nationalIDValidator,
                ),
                const SizedBox(height: 12),

                ///acNo
                TextFormField(
                  controller: acNoController,
                  decoration: InputDecoration(
                    labelText: S.of(context).employeeCode,
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v!.isEmpty ? S.of(context).required : null,
                ),
                const SizedBox(height: 12),

                /// job
                TextFormField(
                  controller: jobController,
                  decoration: InputDecoration(
                    labelText: S.of(context).jobTitle,
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v!.isEmpty ? S.of(context).required : null,
                ),
                const SizedBox(height: 12),

                /// phone
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: S.of(context).phoneNumber,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: phoneValidator,
                ),
                const SizedBox(height: 12),

                /// basicSalary
                TextFormField(
                  controller: basicSalaryController,
                  decoration: InputDecoration(
                    labelText: S.of(context).basicSalary,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) => v!.isEmpty ? S.of(context).required : null,
                ),
                const SizedBox(height: 12),

                /// monthlySalary
                TextFormField(
                  controller: monthlySalaryController,
                  decoration: InputDecoration(
                    labelText: S.of(context).monthlyBalance,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) => v!.isEmpty ? S.of(context).required : null,
                ),
                const SizedBox(height: 12),

                ///yearlySalary
                TextFormField(
                  controller: yearlySalaryController,
                  decoration: InputDecoration(
                    labelText: S.of(context).yearlyBalance,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) => v!.isEmpty ? S.of(context).required : null,
                ),
                const SizedBox(height: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).paymentMethod),
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
                            title: Text(S.of(context).monthlySalary),
                            value: PaymentMethod.monthly,
                          ),
                          RadioListTile<PaymentMethod>(
                            title: Text(S.of(context).weeklySalary),
                            value: PaymentMethod.weekly,
                          ),
                          RadioListTile<PaymentMethod>(
                            title: Text(S.of(context).weeklyAdvance),
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
                    decoration: InputDecoration(
                      labelText: S.of(context).weeklyAdvanceAmount,
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        v!.isEmpty && paymentMethod == PaymentMethod.weeklyAdvance
                        ? S.of(context).required
                        : null,
                  ),
                if (paymentMethod == PaymentMethod.weeklyAdvance)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Text(S.of(context).remainingSalary),
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
                                title: Text(S.of(context).monthly),
                                value: WeeklyAdvanceMethod.monthly,
                              ),
                            ),

                            Expanded(
                              child: RadioListTile<WeeklyAdvanceMethod>(
                                title: Text(S.of(context).yearly),
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
                    Text(S.of(context).employeeStatus),
                    RadioGroup<bool>(
                      onChanged: (value) {
                        setState(() {
                          isActive = value!;
                        });
                      },
                      groupValue: isActive,
                      child: Column(
                        children: [
                          RadioListTile<bool>(
                            title: Text(S.of(context).active),
                            value: true,
                          ),
                          RadioListTile<bool>(
                            title: Text(S.of(context).inactive),
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
                    widget.editEmployee == null
                        ? S.of(context).saveEmployee
                        : S.of(context).updateEmployee,
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
    if (value == null || value.isEmpty) return S.of(context).required;

    if (!RegExp(r'^\d+$').hasMatch(value)) return S.of(context).numbersOnly;

    if (!RegExp(r'^(010|011|012|015)\d{8}$').hasMatch(value)) {
      return S.of(context).invalidPhone;
    }

    return null;
  }

  String? nationalIDValidator(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).required;
    }

    // التحقق من الطول والأرقام فقط
    if (value.length != 14 || !RegExp(r'^\d+$').hasMatch(value)) {
      return S.of(context).nationalIdLength;
    }

    // التحقق من القرن (الرقم الأول)
    String firstDigit = value[0];
    if (firstDigit != '2' && firstDigit != '3') {
      return S.of(context).invalidNationalId;
    }

    // التحقق من تاريخ الميلاد
    int month = int.parse(value.substring(3, 5));
    int day = int.parse(value.substring(5, 7));
    if (month < 1 || month > 12) return S.of(context).invalidBirthMonth;
    if (day < 1 || day > 31) return S.of(context).invalidBirthDay;

    return null; // كل شيء صحيح
  }
}
