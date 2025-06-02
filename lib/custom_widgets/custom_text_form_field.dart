import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Color textColor;
  final Color borderColor;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;  // <-- هنا

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.textColor = Colors.white,
    this.borderColor = Colors.white,
    this.validator,
    this.onChanged,  // <-- ضيفها هنا في الكونستركتور
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      style: TextStyle(color: textColor),
      onChanged: onChanged,  // <-- أمررها هنا
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: borderColor, width: 1.5),
        ),
        hintText: hintText,
        labelText: labelText,
        hintStyle: TextStyle(color: textColor),
        labelStyle: TextStyle(color: textColor),
        suffixIcon: suffixIcon,
      ),
    );
  }
}