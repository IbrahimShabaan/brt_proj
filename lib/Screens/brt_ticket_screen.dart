import 'package:brt_proj/Screens/homepage_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/constants.dart';
import '../features/auth_bloc/transaction_bloc.dart';
import '../features/auth_state/transaction_state.dart';

class BrtTicketScreen extends StatelessWidget {
  const BrtTicketScreen({
    super.key,
    required this.ticketNumber,
    required this.issueDate,
    required this.issueTime,
    required this.station,
    required this.stationCount,
    required this.ticketPrice,
  });

  final String? ticketNumber;
  final String? issueDate;
  final String? issueTime;
  final String? station;
  final int? stationCount;
  final double ticketPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 400.w,
            height: 452.h,
            decoration: BoxDecoration(
              color: ConstColors.kPrimaryColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Center(
              child: Image.asset('assets/images/Ellipse.png', fit: BoxFit.fill),
            ),
          ),
          Positioned(
            top: 40.h,
            left: 10.w,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black, size: 28.sp),
    onPressed: () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomepageScreen()),
      );
    }),
          ),
          BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state is TransactionLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TransactionFailure) {
                return Center(child: Text(state.error));
              } else if (state is TransactionSuccess) {
                final transaction = state.transaction;

                return Positioned(
                  top: 119.h,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 580.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      itemExtent: 340.w, // بيخلي الـ ListView أسرع
                      cacheExtent: 200.w,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: transaction.transactionDetails.length,
                      itemBuilder: (context, index) {
                        final detail = transaction.transactionDetails[index];

                        return Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: RepaintBoundary(
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/images/ticketBackground.png',
                                  fit: BoxFit.fill,
                                  width: 330.w,
                                  height: 580.h,
                                  cacheWidth: 660, 
                                ),
                                Positioned(
                                  top: 20.h,
                                  left: 20.w,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 15.sp),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 8.h),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [

                                            SizedBox(width: 5.w),

                                            Text(
                                              'نرجو لكم رحلة سعيدة',
                                              style: TextStyle(
                                                color: ConstColors.kPrimaryColor,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                        SizedBox(
                                          width: 110.w,
                                          height: 110.h,
                                          child: Image.asset('assets/images/QR.png'),
                                        ),
                                        SizedBox(height: 15.h),
                                        Text(
                                          'الاتوبيس الترددي',
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 15.h),
                                        Text(
                                          'تاريخ الاصدار : ${transaction.createdAt?.toString().split(' ')[0] ?? ''}',
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 15.h),
                                        Text(
                                          'وقت الاصدار : ${transaction.createdAt?.toString().split(' ')[1].split('.')[0] ?? ''}',
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 15.h),
                                        Text(
                                          'المحطة : $station',
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Divider(),
                                        Text(
                                          'رقم التذكرة : ${detail.number}',
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Divider(),
                                        Row(
                                          children: [
                                            Text(
                                              ' عدد المحطات ',
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(width: 35.w),
                                            Text(
                                              ' سعر التذكرة ',
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          children: [
                                            Text(
                                              '${detail.ticketCategory.stationCount}',
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(width: 95.w),
                                            Text(
                                              detail.price.toStringAsFixed(0),
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}