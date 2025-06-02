import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../custom_widgets/auth_widget.dart';

class AccountCreateSuccessfully extends StatelessWidget {
  const AccountCreateSuccessfully({super.key});

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
              SizedBox(height: 100.sp),
              Center(
                child: SizedBox(
                  width: 120.sp,
                  height: 190.sp,
                  child: Image.asset('assets/images/Confetti component.png',fit: BoxFit.cover,),
                ),
              ),
              Center(
                child: Text(
                  "🎊 Your account has been\n successfully created!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Center(
                child: Text(
                  'Welcome! Your account has been successfully registered, and you can now browse the latest offers and products.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 10.sp),



              SizedBox(height: 10.sp),

              SizedBox(height: 15.sp),

              AuthButton(
                buttonText: 'Go to the Homepage', onPressed: () {  },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
