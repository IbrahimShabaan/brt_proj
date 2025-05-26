import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/constants.dart';
import '../custom_widgets/auth_widget.dart';
import '../custom_widgets/custom_text_form_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/loginhome.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 200.sp),
              Text(
                "Let's get started! Create\n your account easily",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                'Enter your email and password\n to enjoy the experience',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10.sp),
              Row(
                children: [
                  SizedBox(
                    width: 153.w,
                    height: 42.h,
                    child:CustomTextFormField(
                      labelText: 'Enter First name',
                      hintText: 'First Name',
                      //controller: emailController,
                      keyboardType: TextInputType.name,
                    ),

                  ),
                  SizedBox(width: 10.sp),
                  SizedBox(
                    width: 153.w,
                    height: 42.h,
                    child:CustomTextFormField(
                      labelText: 'Second Name',
                      hintText: 'Second Name',
                      //controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),

                  ),
                ],
              ),
              SizedBox(height: 15.sp),
              SizedBox(
                width: 323.w,
                height: 42.h,
                child:CustomTextFormField(
                  labelText: 'Email Address',
                  hintText: 'Enter your email address',
                  //controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

              ),
              SizedBox(height: 15.sp),

              SizedBox(
                width: 323.w,
                height: 42.h,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),

                  decoration: InputDecoration(
                    fillColor: Colors.white,

                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    hintText: 'Enter your Password ',
                    labelText: 'Password',
                    hintStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    suffixIcon: Icon(Icons.remove_red_eye_rounded),
                  ),
                ),
              ),

              SizedBox(height: 10.sp),
              Row(
                children: [
                  Container(
                    width: 25.sp,
                    height: 25.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.check, color: Colors.black, size: 20),
                  ),
                  SizedBox(width: 5.sp),

                  Text('Remember me', style: TextStyle(color: Colors.white)),
                  SizedBox(width: 75.sp),

                  Text(
                    'Forget your password?',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 15.sp),

              AuthButton(
                buttonText: 'Sign Up', onPressed: () {  },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have account?",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
