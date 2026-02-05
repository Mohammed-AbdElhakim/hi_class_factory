import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? enabled;
  final int? maxLines;
  final int? maxLength;
  final double borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autoValidate;
  final bool isBorder;
  final TextStyle? hintStyle;
  final bool showPasswordToggle; // لإظهار زر تبديل إخفاء/إظهار كلمة المرور

  const CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.enabled,
    this.maxLines = 1,
    this.borderRadius = 12,
    this.maxLength,
    this.fillColor,
    this.borderColor,
    this.onChanged,
    this.validator,
    this.controller,
    this.focusNode,
    this.autoValidate = false,
    this.isBorder = true,
    this.showPasswordToggle = false,
    this.hintStyle,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      validator: widget.validator,
      autovalidateMode: widget.autoValidate
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        hintText: widget.hint,
        hintStyle: widget.hintStyle,
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: Colors.grey)
            : null,
        fillColor: widget.fillColor,
        filled: widget.fillColor == null ? false : true,
        suffixIcon: _buildSuffixIcon(),
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: !widget.isBorder
              ? BorderSide.none
              : BorderSide(color: widget.borderColor ?? Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: !widget.isBorder
              ? BorderSide.none
              : BorderSide(color: widget.borderColor ?? Colors.grey, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: !widget.isBorder
              ? BorderSide.none
              : const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: !widget.isBorder
              ? BorderSide.none
              : const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    // إذا حدد المستخدم suffixIcon يدويًا → نستخدمه
    if (widget.suffixIcon != null) {
      return Icon(widget.suffixIcon);
    }

    // إذا طلب إظهار زر تبديل كلمة المرور → نضيفه
    if (widget.showPasswordToggle && widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Theme.of(context).iconTheme.color,
        ),
        onPressed: _toggleObscure,
      );
    }

    return null;
  }
}
