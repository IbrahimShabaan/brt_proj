import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/constants.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  const AuthButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width ?? 323.sp,
        height: height ?? 51.sp,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ConstColors.kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.sp,
              fontFamily: AppFonts.lalezar,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}