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
  final jobController = TextEditingController();
  final phoneController = TextEditingController();
  final absenceController = TextEditingController();
  final delayController = TextEditingController();
  final stopController = TextEditingController();

  void _saveEmployee() {
    if (!_formKey.currentState!.validate()) return;

    final employee = EmployeeModel(
      id: widget.editEmployee?.id ?? "",
      name: nameController.text,
      jobTitle: jobController.text,
      phone: phoneController.text,
      absentDays: int.parse(absenceController.text),
      lateDays: int.parse(delayController.text),
      workStops: int.parse(stopController.text),
    );

    Navigator.pop(context, employee);
  }

  @override
  void initState() {
    super.initState();
    if (widget.editEmployee != null) {
      nameController.text = widget.editEmployee!.name;
      jobController.text = widget.editEmployee!.jobTitle;
      phoneController.text = widget.editEmployee!.phone;
      absenceController.text = widget.editEmployee!.absentDays.toString();
      delayController.text = widget.editEmployee!.lateDays.toString();
      stopController.text = widget.editEmployee!.workStops.toString();
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

              /// absence
              TextFormField(
                controller: absenceController,
                decoration: const InputDecoration(
                  labelText: "أيام الغياب",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? "مطلوب" : null,
              ),
              const SizedBox(height: 12),

              /// delay
              TextFormField(
                controller: delayController,
                decoration: const InputDecoration(
                  labelText: "أيام التأخير",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? "مطلوب" : null,
              ),
              const SizedBox(height: 12),

              ///stop
              TextFormField(
                controller: stopController,
                decoration: const InputDecoration(
                  labelText: "التوقف عن العمل",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? "مطلوب" : null,
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
    );
  }
}
