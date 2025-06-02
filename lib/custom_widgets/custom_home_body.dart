import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/constants.dart';
import 'auth_widget.dart';
import 'custom_datepicker.dart';

class CustomHomeBody extends StatelessWidget {
   CustomHomeBody({super.key});
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Positioned(
      top: 180.h,
      left: 20.w,
      child: Container(
        width: 334.w,
        height: 510.h,
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
        child: Center(
          child: Column(
            children: [
              Icon(Icons.linear_scale_sharp),
              SizedBox(height: 5.h),
              Text(
                "Available lines",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Container(
                      height: 60.h,
                      width: 143.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),

                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 3.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('From', textAlign: TextAlign.start),
                          Text(
                            'المعادي',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: AppFonts.cairo,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.switch_right_sharp,
                      size: 30,
                      color: Colors.blue[500],
                    ),
                    Container(
                      height: 60.h,
                      width: 143.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 3.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('To', textAlign: TextAlign.start),
                          Text(
                            'جسر السويس',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: AppFonts.cairo,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'TICKET 1',
                    hintText: 'Example 1',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ), // rounded corners
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ), // optional: customize border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ), // optional: when field is focused
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomDatePickerFormField(
                  labelText: "Reserve Date",
                  hintText: "example : 16, Jan 2023",
                  controller: dateController,
                  textColor: Colors.black,
                  borderColor: Colors.grey,

                ),
              ),

              SizedBox(height: 10.h),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Payment Methods',
                    hintText: 'Fawry Method',
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 7),
                      child: Image.asset(
                        'assets/images/fawry.png',
                        width: 75.w,
                        height: 26.h,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ), // rounded corners
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ), // optional: customize border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ), // optional: when field is focused
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10.h),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Expected Price',
                    hintText: '150 EGP',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ), // rounded corners
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ), // optional: customize border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ), // optional: when field is focused
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AuthButton(
                  buttonText: 'Find Transportation',

                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
