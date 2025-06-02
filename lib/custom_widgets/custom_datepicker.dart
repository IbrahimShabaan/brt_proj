import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePickerFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Color textColor;
  final Color borderColor;
  final String? Function(String?)? validator;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const CustomDatePickerFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.suffixIcon,
    this.textColor = Colors.white,
    this.borderColor = Colors.white,
    this.validator,
    this.firstDate,
    this.lastDate,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
    );

    if (picked != null && controller != null) {
      controller!.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      validator: validator,
      style: TextStyle(color: textColor),
      onTap: () => _selectDate(context),
      decoration: InputDecoration(


        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            12.0,
          ), // rounded corners
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Colors.grey,
          ), // optional: customize border color
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Colors.blue,
          ), // optional: when field is focused
        ),
        hintText: hintText,
        labelText: labelText,
        hintStyle: TextStyle(color: textColor),
        labelStyle: TextStyle(color: textColor),
        suffixIcon: suffixIcon ?? Icon(Icons.calendar_today, color: textColor),
      ),
    );
  }
}





