import 'package:brt_proj/Screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import '../const/constants.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}




class _StartScreenState extends State<StartScreen> {

  @override
  void initState() {
    super.initState();


    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignupScreen()),
      );
    });
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.kPrimaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: SizedBox(
              width: 150.sp,
              height: 340.sp,
              child: Image.asset('assets/images/img.png'),
            ),
          ),
          Center(
            child: Padding(
              padding:  EdgeInsets.only(left: 60.sp),
              child: Row(
                children: [
                  Text(
                    'BRT \nBus Rapid Transit',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontFamily: AppFonts.lalezar,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: SizedBox(
                      width: 110.sp,
                      height: 366.sp,
                      child: Image.asset('assets/images/img_1.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),

Flexible(child: Align(

  alignment: Alignment.bottomRight,
  child: Padding(
    padding: EdgeInsets.only(bottom: 0, right: 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('وزاره النقـــل\nالاتوبيس الترددي',
          textAlign: TextAlign.end,
          style: TextStyle(fontSize: 12,color: Colors.white,fontFamily:AppFonts.lalezar,),),

        Container(
          // width: 95.sp,
          // height: 95.sp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/icons/logo.png',
              //fit: BoxFit.fill,
              height: 75.sp,
              width: 75.sp,
            ),
          ),
        )
      ],
    ),
  ),

),

),
          SizedBox(height: 70,),

        ],
      ),
    );
  }
}
