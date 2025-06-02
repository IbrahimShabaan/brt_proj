import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/constants.dart';

class BrtTicketScreen extends StatelessWidget {
  const BrtTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(

        clipBehavior: Clip.none,
        children: [

          Container(
            width: 400.w,
            height: 252.h,
            decoration: BoxDecoration(
              color: ConstColors.kPrimaryColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/Ellipse.png',
                fit: BoxFit.fill,
              ),
            ),
          ),

          Positioned(
            top: 119.h,
            left: 30.w,
            child: Stack(
              children: [
                // 📸 Background Image
                Image.asset(
                  'assets/images/ticketBackground.png',
                  fit: BoxFit.fill,
                 width: 330.w,
                  height: 390.h,
                ),

                Positioned(
                  top: 20.h,
                  left: 20.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center, // ← مهم جداً

                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Align(
                          alignment: Alignment.centerLeft, // ← هنا بتخليه يبدأ من الشمال

                          child: Row(

                            children: [
                              Image.asset(
                                'assets/images/Frame.png',
                                width: 24.w,
                                height: 24.h,
                              ),
                             SizedBox(width: 5.w,),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(
                                   'BRT',
                                   style: TextStyle(
                                     color: ConstColors.kPrimaryColor,
                                     fontSize: 10.sp,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                                 Text(
                                   'Ticket #2231',
                                   style: TextStyle(
                                     color: ConstColors.kPrimaryColor,
                                     fontSize: 16.sp,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                               ],
                             ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18,right: 35,),
                        child: Row(
                          children: [
                            Icon(Icons.crop_square,size: 10,),
                            SizedBox(width: 5.w,),
                            Text('Al zahraa',style: TextStyle(fontSize: 14.sp,
                            color: ConstColors.kPrimaryColor,
                              fontWeight: FontWeight.bold
                            ),),
                            SizedBox(width: 15.w,),


                            Image.asset('assets/images/Group.png',width: 73.w,height: 19.h,),
                            SizedBox(width: 15.w,),
                            Icon(Icons.gps_fixed,size: 10,),
                            SizedBox(width: 5.w,),

                            Text('Al salam',style: TextStyle(fontSize: 14.sp,
                                color: ConstColors.kPrimaryColor,
                                fontWeight: FontWeight.bold
                            ),),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 18,right: 18,top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Departure\n16, Jan 2023',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.sp,
                                color: Colors.grey
                            ),),
                            SizedBox(width: 20.w,),
                            Text('Distance\n35km',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.sp,
                                color: Colors.grey
                            ),),
                            SizedBox(width: 20.w,),

                            Text('No.Ticket\n5',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.sp,
                                color: Colors.grey
                            ),),
                            SizedBox(width: 20.w,),

                            Text('Price\n150 LE',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.sp,
                                color: Colors.grey
                            ),),
                            SizedBox(width: 20.w,),


                          ],
                        ),
                      ),
                      SizedBox(height: 15.h,),

                      SizedBox(

                        width: 255.w,
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0,
                        ),
                      ),

                      SizedBox(height: 25.h,),
                      SizedBox(
                        width: 110.w,
                        height: 110.h,
                        child: Image.asset('assets/images/QR.png'),
                      ),
                      SizedBox(height: 15.h,),

                      Text('قم بمسح رمز الاستجابة السريعة هذا عند البوابة قبل\n بطاقة الصعود إلى الاوتوبيس'
                      ,style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.grey[700]
                        ),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }}