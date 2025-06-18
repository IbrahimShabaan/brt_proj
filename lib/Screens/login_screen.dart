import 'package:brt_proj/Screens/signup_screen.dart';
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

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => Center(child: CircularProgressIndicator()),
            );
          } else if (state is AuthSuccess) {
            Navigator.pop(context); // remove loading dialog
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomepageScreen()),
            );
          } else if (state is AuthFailure) {
            Navigator.pop(context); // remove loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 812.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/loginhome.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20.sp),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 200.sp),
                    Text(
                      "Welcome Back!\nLogin to your account".tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Enter your phone number and password\n to continue'.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    // Phone Number Field
                    SizedBox(
                      width: 323.w,
                      height: 42.h,
                      child: CustomTextFormField(
                        labelText: 'Phone Number'.tr(),
                        hintText: 'Enter your phone number'.tr(),
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone number is required'.tr();
                          } else if (!RegExp(r'^(01)[0-9]{9}$').hasMatch(value)) {
                            return 'Enter valid Egyptian phone number'.tr();
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 15.sp),
                    // Password Field
                    SizedBox(
                      width: 323.w,
                      height: 42.h,
                      child: CustomTextFormField(
                        labelText: 'Password'.tr(),
                        hintText: 'Enter your Password'.tr(),
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
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        obscureText: _obscurePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required'.tr();
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters'.tr();
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 15.sp),
                    // Login Button
                    AuthButton(
                        // buttonText: transalt.'Login'.tr(),
                //
                buttonText: 'Login'.tr(),
                      onPressed: () {

                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(
                            LoginSubmitted(
                              phoneNumber: phoneController.text,
                              password: passwordController.text,

                            ),
                          );
                        }
                      },
                    ),
                    // Signup Option
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?".tr(), style: TextStyle(color: Colors.white)),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => SignupScreen()),
                            );
                          },
                          child: Text(
                            "Sign up".tr(),
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
          ),
        ),
      ),
    );
  }
}