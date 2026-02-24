import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../data/models/profile_model.dart';

class EditProfileBottomSheet extends StatefulWidget {
  const EditProfileBottomSheet({super.key, this.editProfile});
  final ProfileModel? editProfile;

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final descriptionController = TextEditingController();
  final phone1Controller = TextEditingController();
  final phone2Controller = TextEditingController();
  final addressController = TextEditingController();

  void _saveProfile() {
    if (!_formKey.currentState!.validate()) return;

    final profile = ProfileModel(
      name: AppStrings.factoryName,
      description: descriptionController.text,
      phone1: phone1Controller.text,
      phone2: phone2Controller.text,
      address: addressController.text,
    );

    Navigator.pop(context, profile);
  }

  @override
  void initState() {
    super.initState();
    if (widget.editProfile != null) {
      descriptionController.text = widget.editProfile!.description;
      phone1Controller.text = widget.editProfile!.phone1;
      phone2Controller.text = widget.editProfile!.phone2;
      addressController.text = widget.editProfile!.address;
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
                widget.editProfile == null
                    ? "إضافة بيانات المصنع"
                    : "تعديل بيانات المصنع",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              /// description
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "وصف المصنع",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                validator: (v) => v!.isEmpty ? "مطلوب" : null,
              ),
              const SizedBox(height: 12),

              /// phone1
              TextFormField(
                controller: phone1Controller,

                decoration: const InputDecoration(
                  labelText: "رقم الهاتف",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (v) => v!.isEmpty ? "مطلوب" : null,
              ),
              const SizedBox(height: 12),

              /// phone2
              TextFormField(
                controller: phone2Controller,
                decoration: const InputDecoration(
                  labelText: "رقم الهاتف آخر",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (v) => v!.isEmpty ? "مطلوب" : null,
              ),
              const SizedBox(height: 12),

              /// address
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: "العنوان",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.streetAddress,
                validator: (v) => v!.isEmpty ? "مطلوب" : null,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkCard,
                  minimumSize: const Size(double.infinity, 35),
                ),
                child: Text(
                  widget.editProfile == null ? "حفظ" : "تعديل",
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
