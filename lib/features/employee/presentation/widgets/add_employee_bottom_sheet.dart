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
  final monthlySalaryController = TextEditingController();
  PaymentMethod paymentMethod = PaymentMethod.weeklyAdvance;
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
      monthlySalary: double.parse(monthlySalaryController.text.trim()),
      paymentMethod: paymentMethod,
      weeklyAdvanceAmount: paymentMethod == PaymentMethod.weeklyAdvance
          ? double.parse(weeklyAdvanceAmountController.text.trim())
          : null,
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
      monthlySalaryController.text = widget.editEmployee!.monthlySalary.toString();
      weeklyAdvanceAmountController.text =
          widget.editEmployee!.paymentMethod == PaymentMethod.weeklyAdvance
          ? widget.editEmployee!.weeklyAdvanceAmount.toString()
          : "";
      isActive = widget.editEmployee!.isActive;
      paymentMethod = widget.editEmployee!.paymentMethod;
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
                  validator: (v) => v!.isEmpty ? "مطلوب" : null,
                ),
                const SizedBox(height: 12),

                /// monthlySalary
                TextFormField(
                  controller: monthlySalaryController,
                  decoration: const InputDecoration(
                    labelText: "المرتب الشهري",
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
}
