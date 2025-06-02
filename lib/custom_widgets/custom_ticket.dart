import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/constants.dart';

class CustomTicket extends StatelessWidget {
  const CustomTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 760.h,
      left: 20.w,
      child: Container(
        width: 334.w,
        height: 188.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text('Al zahraa'),
                  Column(
                    children: [
                      Text('BRT',
                        style: TextStyle(
                            color: ConstColors.kPrimaryColor,
                            fontWeight: FontWeight.bold

                        ),),
                      Text('Bus Rapid Transit',
                        style: TextStyle(
                          color: ConstColors.kPrimaryColor,

                        ),
                      ),
                    ],
                  ),


                  Row(
                    children: [
                      Icon(Icons.gps_fixed),
                      SizedBox(width: 8.w,),
                      Text('Al salam'),
                    ],
                  ),


                ],

              ),
              Divider(
                color: ConstColors.kPrimaryColor,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Departure',style: TextStyle(color: Colors.grey),),
                    Text('Distance',style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('16, Jan 2023',),
                    Text('35km'),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Image.asset('assets/images/Info.png'),

              Row(
                children: [
                  Text('EGP 150',style: TextStyle(color: ConstColors.kPrimaryColor,fontWeight: FontWeight.bold,fontSize: 16.sp),),
                  SizedBox(width: 10.w,),
                  Text('Ticket Price',style: TextStyle(color: Colors.grey),),
                  Spacer(),
                  Text('View Details'),
                ],
              ),
            ],
          ),

        ),

      ),
    );
  }
}
