import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../auth_feature/auth_bloc/auth_bloc.dart';
import '../auth_feature/auth_event/auth_event.dart';
import '../auth_feature/auth_state/auth_state.dart';
import '../custom_widgets/auth_widget.dart';
import '../custom_widgets/custom_text_form_field.dart';
import 'homepage_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                      "Welcome Back!\nLogin to your account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Enter your phone and password\n to continue',
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
                        labelText: 'Phone Number',
                        hintText: 'Enter your phone number',
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone number is required';
                          } else if (!RegExp(r'^(01)[0-9]{9}$').hasMatch(value)) {
                            return 'Enter valid Egyptian phone number';
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
                        labelText: 'Password',
                        hintText: 'Enter your Password',
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 15.sp),
                    // Login Button
                    AuthButton(
                      buttonText: 'Login',
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
                        Text("Don't have an account?", style: TextStyle(color: Colors.white)),
                        TextButton(
                          onPressed: () {
                            // Navigate to signup
                          },
                          child: Text(
                            "Sign up",
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