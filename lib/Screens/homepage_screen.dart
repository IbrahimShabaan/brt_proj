import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../const/constants.dart';
import '../custom_widgets/custom_home_body.dart';
import '../custom_widgets/custom_ticket.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 990.h,
          child: Stack(
            children: [
              Container(
                color: ConstColors.kPrimaryColor,
                width: 375.w,
                height: 308.h,
                child: Image.asset(
                  'assets/desgin/img1design.png',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 80.h,
                left: 20.w,
                child: Text(
                  "Morning Dear,",
                  style: TextStyle(color: Colors.white38, fontSize: 14.sp),
                ),
              ),
              Positioned(
                top: 100.h,
                left: 20.w,
                child: Text(
                  "Where are you",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                top: 120.h,
                left: 20.w,
                child: Text(
                  "Going Today?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
           CustomHomeBody(),
           Positioned(
             top: 720.h,
             left: 20.w,
             child: Row(
               children: [
                 Text(
                   'My Trips',
                   style: TextStyle(color: ConstColors.kPrimaryColor
                       ,fontWeight: FontWeight.bold,
                       fontSize: 20.sp),
                 ),
                 SizedBox(width: 190.w),
                 Text(
                   'Show All',
                   style: TextStyle(color: ConstColors.kPrimaryColor),
                 ),
               ],
             ),
           ),
           //Custom_Ticket
           CustomTicket(),



            ],
          ),
        ),
      ),
    );
  }
}
