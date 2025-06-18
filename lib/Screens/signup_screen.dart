import 'package:brt_proj/Screens/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../custom_widgets/auth_widget.dart';
import '../custom_widgets/custom_text_form_field.dart';
import '../features/auth_bloc/auth_bloc.dart';
import '../features/auth_event/auth_event.dart';
import '../features/auth_state/auth_state.dart';
import 'homepage_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureConfirmPassword = true;
  bool _obscurePassword = true;
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomepageScreen()),
            );
          } else if (state is SignupFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Registration failed: ${state.error}')),
            );
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/loginhome.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20.sp),
            child: Form(
              key: _formKey,
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final authBloc = context.read<AuthBloc>();

                  // نحصل على كلمة السر من الحالة الحالية
                  // String passwordFromState = '';
                  // if (state is AuthInitial) {
                  //   passwordFromState = state.password;
                  // }

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 200.sp),
                        Text(
                          "Let's get started! Create\n your account easily".tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Enter your Phone Number and Password\n to enjoy the experience'.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 15.sp),

                        SizedBox(
                          width: 323.w,
                          height: 42.h,
                          child: CustomTextFormField(
                            labelText: 'Phone Number'.tr(),
                            hintText: 'Enter your phone number'.tr(),
                            keyboardType: TextInputType.phone,
                            onChanged: (value) =>
                                authBloc.add(UpdatePhone(value)),
                            validator: (value) =>
                            value == null || value.isEmpty
                                ? 'Phone number is required'
                                : null,
                          ),
                        ),
                        SizedBox(height: 15.sp),

                        SizedBox(
                          width: 323.w,
                          height: 42.h,
                          child: TextFormField(
                            obscureText: _obscurePassword,
                            controller: _passwordController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 10.h),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.r)),
                              hintText: 'Enter your Password'.tr(),
                              labelText: 'Password'.tr(),
                              hintStyle: const TextStyle(color: Colors.white),
                              labelStyle: const TextStyle(color: Colors.white),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            onChanged: (value) =>
                                authBloc.add(UpdatePassword(value)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              } else if (value.length < 8) {
                                return 'Password must be at least 8 characters';
                              } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                return 'Must contain uppercase letter';
                              } else if (!RegExp(r'[a-z]').hasMatch(value)) {
                                return 'Must contain lowercase letter';
                              } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                                return 'Must contain a number';
                              } else if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
                                return 'Must contain a special character';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 15.sp),

                        SizedBox(
                          width: 323.w,
                          height: 42.h,
                          child: TextFormField(
                            obscureText: _obscureConfirmPassword,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 10.h),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.r)),
                              hintText: 'Enter Confirm Password'.tr(),
                              labelText: 'Confirm Password'.tr(),
                              hintStyle: const TextStyle(color: Colors.white),
                              labelStyle: const TextStyle(color: Colors.white),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                                  });
                                },
                              ),
                            ),
                            onChanged: (value) =>
                                authBloc.add(UpdateConfirmPassword(value)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm Password is required'.tr();
                              } else if (value.length < 8) {
                                return 'Minimum 8 characters'.tr();
                              } else if (value != _passwordController.text) {
                                return 'Passwords do not match'.tr();
                              }
                              return null;
                            },
                          ),
                        ),

                        SizedBox(height: 15.sp),

                        Row(
                          children: [
                            Container(
                              width: 25.sp,
                              height: 25.sp,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.check,
                                  color: Colors.black, size: 20),
                            ),
                            SizedBox(width: 5.sp),
                             Text('Remember me'.tr(),
                                style: TextStyle(color: Colors.white)),
                            SizedBox(width: 75.sp),
                             Text('Forget your password?'.tr(),
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),

                        SizedBox(height: 15.sp),

                        AuthButton(
                          buttonText: state is SignupLoading
                              ? 'Signing Up...'
                              : 'Sign Up',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              authBloc.add(SignupSubmitted());
                            }
                          },
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text("Already have account?".tr(),
                                style: TextStyle(color: Colors.white)),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginScreen()),
                                );
                              },


                              child:  Text(
                                "Login".tr(),
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
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}